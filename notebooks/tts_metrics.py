import pandas as pd
import numpy as np


################################
# Event match rate calculation
################################

def calculate_match_rate(df: pd.DataFrame, threshold: float) -> pd.DataFrame:
    """
    Calculate event match rate.
    Match rate = percentage of events where error.rate < threshold
    """
    df_clean = df.copy()
    df_clean['error.rate'] = df_clean['error.rate'].fillna(np.inf)
    
    # Use groupby and agg to calculate match rate without triggering deprecation warning
    results = df_clean.groupby('pilot_name').agg(
        match_rate=('error.rate', lambda x: (x < threshold).mean())
    ).reset_index()
    
    return results


##################################
# Concordance calculation
##################################

def r_style_cindex_counts(
    df_one_file: pd.DataFrame,
    ties_value: float = 0.5,
    nonzero_threshold: float = 1e-5,
    truth_col: str = "ref.time",
    pred_col: str = "pilot.time",
):
    """
    Exact analog of the R my_cindex() logic used in your `remove` branch:

      crossing(pred, truth) x crossing(pred2, truth2)
      filter(abs(truth - truth2) > nonzero_threshold)
      score = 1 if (truth-truth2)*(pred-pred2) > 0
              ties_value if > -nonzero_threshold
              0 otherwise

    IMPORTANT R-faithful filtering:
      - R filters out NA pred (time.pilot) BEFORE computing C-index.
      - R does NOT explicitly filter out NA truth (time); pairs involving NA drop out later.
    """

    truth = pd.to_numeric(df_one_file[truth_col], errors="coerce")
    pred  = pd.to_numeric(df_one_file[pred_col], errors="coerce")

    # Match R remove-branch: filter(!is.na(time.pilot))
    keep = ~pred.isna()
    truth = truth[keep]
    pred  = pred[keep]

    n = int(len(pred))
    if n == 0:
        return dict(cindex=np.nan, score_sum=0.0, denom=0, concordant=0, ties=0, n_rows_used=0)

    t = truth.to_numpy(dtype=float)  # may contain NaN (allowed, matches R behavior)
    p = pred.to_numpy(dtype=float)

    # Ordered pairs (i, j), like R's crossing()
    dt = t[:, None] - t[None, :]
    dp = p[:, None] - p[None, :]

    # filter(abs(truth-truth2) > nonzero_threshold)
    # Note: comparisons involving NaN become False, which matches dplyr filter dropping NAs.
    mask = np.abs(dt) > nonzero_threshold

    prod = dt * dp

    denom = int(mask.sum())
    if denom == 0:
        return dict(cindex=np.nan, score_sum=0.0, denom=0, concordant=0, ties=0, n_rows_used=n)

    concordant = int(((prod > 0) & mask).sum())
    ties = int(((prod <= 0) & (prod > -nonzero_threshold) & mask).sum())

    score_sum = concordant + ties_value * ties
    cindex = score_sum / denom

    return dict(
        cindex=float(cindex),
        score_sum=float(score_sum),
        denom=denom,
        concordant=concordant,
        ties=ties,
        n_rows_used=n,
    )


def calculate_concordance(
    match_df: pd.DataFrame,
    threshold: float = 0.1,
    ties_value: float = 0.5,
    nonzero_threshold: float = 1e-5,
    truth_col: str = "ref.time",
    pred_col: str = "pilot.time",
) -> pd.DataFrame:
    """
    Produce the per-file table: (pilot, file) -> cindex + numerator/denominator etc.

    Matches the R remove-branch behavior:
      df %>% filter(error.rate < threshold) %>% ... %>% my_cindex(pred=time.pilot, truth=time)
    """

    df = match_df.copy()

    # R filters error.rate < threshold BEFORE nesting / cindex
    df = df[df["error.rate"] < threshold]

    # Handle either naming convention
    pilot_col = "pilot.names" if "pilot.names" in df.columns else "pilot_name"
    file_col = "common.bns"

    rows = []
    for i, ((pilot, common_bns), g) in enumerate(df.groupby([pilot_col, file_col], sort=True), start=1):
        out = r_style_cindex_counts(
            g,
            ties_value=ties_value,
            nonzero_threshold=nonzero_threshold,
            truth_col=truth_col,
            pred_col=pred_col,
        )
        rows.append({
            "pilot.names": pilot,     # keep R-style output column name
            "common.bns": common_bns,
            **out
        })

    return pd.DataFrame(rows)


####################################
# Anchored C-index calculation
####################################

def _resolve_mask(df, mask_spec=None):
    """
    Convert a mask specification into a boolean Series aligned to df.index.

    Supported:
      - None -> all rows
      - callable(df) -> boolean Series
      - string -> interpreted as a column name; keeps rows where df[col] == 1
      - boolean Series / numpy array / list
    """
    if mask_spec is None:
        return pd.Series(True, index=df.index)

    if callable(mask_spec):
        mask = mask_spec(df)
    elif isinstance(mask_spec, str):
        if mask_spec not in df.columns:
            raise KeyError(f"Mask column '{mask_spec}' not found in DataFrame.")
        mask = df[mask_spec] == 1
    else:
        mask = pd.Series(mask_spec, index=df.index)

    mask = pd.Series(mask, index=df.index)
    return mask.fillna(False).astype(bool)


def anchor_r_style_cindex_counts(
    df_one_file,
    eval_mask=None,
    anchor_mask=None,   # None = everything
    ties_value=0.5,
    nonzero_threshold=1e-5,
    truth_col="ref.time",
    pred_col="pilot.time",
):
    """
    Anchored concordance for a single file.

    Pairs are:
        i in evaluation subset
        j in anchor subset

    Default anchor_mask=None means j ranges over ALL retained rows in the file.
    """
    truth = pd.to_numeric(df_one_file[truth_col], errors="coerce")
    pred = pd.to_numeric(df_one_file[pred_col], errors="coerce")

    # Match existing concordance behavior: drop missing predicted time
    keep = ~pred.isna()
    df_used = df_one_file.loc[keep].copy()
    truth = truth.loc[keep]
    pred = pred.loc[keep]

    if len(df_used) == 0:
        return dict(cindex=np.nan, denom=0, concordant=0, ties=0)

    eval_keep = _resolve_mask(df_used, eval_mask)
    anchor_keep = _resolve_mask(df_used, anchor_mask)

    t_eval = truth.loc[eval_keep].to_numpy(dtype=float)
    p_eval = pred.loc[eval_keep].to_numpy(dtype=float)

    t_anchor = truth.loc[anchor_keep].to_numpy(dtype=float)
    p_anchor = pred.loc[anchor_keep].to_numpy(dtype=float)

    if len(t_eval) == 0 or len(t_anchor) == 0:
        return dict(cindex=np.nan, denom=0, concordant=0, ties=0)

    dt = t_eval[:, None] - t_anchor[None, :]
    dp = p_eval[:, None] - p_anchor[None, :]

    # removes self-comparisons and exact truth ties
    mask = np.abs(dt) > nonzero_threshold
    prod = dt * dp

    denom = int(mask.sum())
    if denom == 0:
        return dict(cindex=np.nan, denom=0, concordant=0, ties=0)

    concordant = int(((prod > 0) & mask).sum())
    ties = int(((prod <= 0) & (prod > -nonzero_threshold) & mask).sum())

    score_sum = concordant + ties_value * ties
    cindex = score_sum / denom

    return dict(
        cindex=float(cindex),
        denom=denom,
        concordant=concordant,
        ties=ties,
    )


def calculate_anchor_concordance(
    match_df,
    threshold=0.1,
    eval_mask=None,
    anchor_mask=None,   # None = everything
    ties_value=0.5,
    nonzero_threshold=1e-5,
    truth_col="ref.time",
    pred_col="pilot.time",
):
    """
    Per-file anchored concordance.
    """
    df = match_df.copy()
    df = df[df["error.rate"] < threshold]

    pilot_col = "pilot.names" if "pilot.names" in df.columns else "pilot_name"
    file_col = "common.bns"

    rows = []
    for (pilot, common_bns), g in df.groupby([pilot_col, file_col], sort=True):
        out = anchor_r_style_cindex_counts(
            g,
            eval_mask=eval_mask.loc[g.index] if isinstance(eval_mask, pd.Series) else eval_mask,
            anchor_mask=anchor_mask,
            ties_value=ties_value,
            nonzero_threshold=nonzero_threshold,
            truth_col=truth_col,
            pred_col=pred_col,
        )
        rows.append({
            "pilot.names": pilot,
            "common.bns": common_bns,
            **out
        })

    return pd.DataFrame(rows)



####################################
# AULTC calculation
####################################

"""
AULTC (Area Under Log Time Curve) calculation matching R implementation.

This calculates the area under the empirical CDF curve of log-transformed
time discrepancies between matched annotations.
"""

def ecdf_auc2(field_values, upper_limit):
    """
    Calculate AUC of empirical CDF.
    
    Matches R's ecdf_auc2 function which:
    1. Adds upper bound to data
    2. Sorts values
    3. Caps at upper limit
    4. Computes empirical CDF areas as rectangles
    5. Normalizes by upper limit
    
    Args:
        field_values: Array of log-transformed time differences
        upper_limit: Upper bound for the curve (log scale)
        
    Returns:
        Normalized AUC value
    """
    # Combine data with upper bound
    df = pd.DataFrame({'field': list(field_values) + [upper_limit]})
    
    # Sort by field
    df = df.sort_values('field').reset_index(drop=True)
    
    # Cap values at upper
    df['field'] = df['field'].clip(upper=upper_limit)
    
    # Calculate next value (lead)
    df['field2'] = df['field'].shift(-1, fill_value=0)
    
    # Calculate empirical CDF positions
    # R: nth = (1:n())/(n()-1)
    n = len(df)
    df['nth'] = np.arange(1, n + 1) / (n - 1)
    
    # Calculate step size and box area
    df['dx'] = df['field2'] - df['field']
    df['box'] = df['dx'] * df['nth']
    
    # Remove last row (after computing boxes)
    df = df.iloc[:-1]
    
    # Sum boxes and normalize by upper limit
    auc = df['box'].sum() / upper_limit
    
    return float(auc)


def calculate_aultc_simple(df, threshold=0.1, upper_limit=None, 
                    version_column=None):
    """
    Calculate AULTC (Area Under Log Time Curve) for time discrepancy.
    
    This matches R's calculate_time_discrepancy function.
    
    Args:
        df: best_matches DataFrame with columns:
            - error.rate: matching error rate
            - time/time.pilot OR ref.time/pilot.time: time values
            - optionally a version/grouping column
        threshold: Distance threshold for filtering matches
        upper_limit: Upper bound for log time (default: log(60*24*365.26) ≈ 1 year)
        version_column: Column name to group by (e.g., 'pilot.names', 'Version')
                       If None, calculates overall AULTC
        
    Returns:
        If version_column is None: float (overall AULTC)
        If version_column is set: DataFrame with columns [version_column, 'auc']
    """
    if upper_limit is None:
        upper_limit = np.log(60 * 24 * 365.26)  # 1 year in log minutes
    
    out = df.copy()
    
    # Map CSV columns to R's internal naming
    if 'time' not in out.columns:
        if 'ref.time' in out.columns:
            out = out.rename(columns={'ref.time': 'time'})
        else:
            raise ValueError("Missing time column (need 'time' or 'ref.time')")
    
    if 'time.pilot' not in out.columns:
        if 'pilot.time' in out.columns:
            out = out.rename(columns={'pilot.time': 'time.pilot'})
        else:
            raise ValueError("Missing pilot time column (need 'time.pilot' or 'pilot.time')")
    
    # Apply R's filtering logic - EXACTLY matching R code line 520-524:
    # mutate(time.pilot = as.numeric(time.pilot)) %>%
    # filter(!is.na(time.pilot), !is.na(event)) %>%
    # mutate(keep=error.rate < threshold, threshold = threshold) %>%
    # filter(keep) %>%
    
    out['error.rate'] = pd.to_numeric(out['error.rate'], errors='coerce')
    out = out[(out['error.rate'].notna()) & 
              (out['error.rate'] < threshold) &
              (np.isfinite(out['error.rate']))].copy()
    
    if len(out) == 0:
        if version_column:
            return pd.DataFrame(columns=[version_column, 'auc'])
        return np.nan
    
    # Convert times to numeric - matching R exactly
    # R: as.numeric(time.pilot) and as.numeric(time)
    out['time'] = pd.to_numeric(out['time'], errors='coerce')
    out['time.pilot'] = pd.to_numeric(out['time.pilot'], errors='coerce')
    
    # R has additional filters!
    # filter(!is.na(time.pilot), !is.na(event))
    out = out[out['time.pilot'].notna()].copy()
    if 'event' in out.columns or 'v1' in out.columns:
        event_col = 'event' if 'event' in out.columns else 'v1'
        out = out[out[event_col].notna()].copy()
    
    if len(out) == 0:
        if version_column:
            return pd.DataFrame(columns=[version_column, 'auc'])
        return np.nan
    
    # Calculate absolute error
    # R: ae = abs(as.numeric(time.pilot) - as.numeric(time))
    out['ae'] = (out['time.pilot'] - out['time']).abs()
    
    # Calculate log absolute error + 1
    # R: lae = ifelse(is.na(ae), exp(upper_limit)+1, ae+1)
    out['lae'] = np.where(
        out['ae'].isna(),
        np.exp(upper_limit) + 1,
        out['ae'] + 1
    )
    
    # Group by version if specified, otherwise calculate overall
    if version_column and version_column in out.columns:
        # R: select(Version, lae) %>% nest(data=-Version)
        results = []
        for version, group in out.groupby(version_column, sort=False):
            if len(group) > 0:
                # R: field=lae %>% mutate(field=log(field)) %>% ecdf_auc2
                field_values = np.log(group['lae'].values)
                auc = ecdf_auc2(field_values, upper_limit)
                results.append({version_column: version, 'auc': auc})
        
        return pd.DataFrame(results)
    else:
        # Calculate overall AULTC
        field_values = np.log(out['lae'].values)
        return ecdf_auc2(field_values, upper_limit)


def calculate_aultc(df, threshold=0.1, upper_limit=None):
    """
    Simplified AULTC calculation for flat best_matches DataFrame.
    
    Handles both column naming conventions:
    - R internal: 'time' and 'time.pilot'
    - CSV format: 'ref.time' and 'pilot.time'
    
    Args:
        df: DataFrame with error.rate and time columns
        threshold: Error rate threshold
        upper_limit: Upper bound for log time (default: log(1 year in minutes))
        
    Returns:
        Float AULTC value
    """
    if upper_limit is None:
        upper_limit = np.log(60 * 24 * 365.26)
    
    return calculate_aultc_simple(
        df, 
        threshold=threshold,
        upper_limit=upper_limit,
        version_column=None
    )