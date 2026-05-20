# T2S2: Textual Time Series Corpus for Sepsis

### Reconstructing Sepsis Trajectories from Clinical Case Reports using LLMs: the Textual Time Series Corpus for Sepsis
**Shahriar Noroozizadeh, Jeremy C. Weiss**

📄 CHIL 2026 Paper: https://arxiv.org/abs/2504.12326

---

## Overview

Clinical case reports contain rich retrospective narratives of patient care, but they are not naturally represented as structured timelines. Events are often described retrospectively, with clinically important findings appearing out of chronological order and timestamps expressed implicitly in free text.

**T2S2 (Textual Time Series for Sepsis)** introduces a pipeline for reconstructing clinical event trajectories from free-text case reports using large language models (LLMs). The resulting corpus represents patient narratives as **event–timestamp trajectories**, where timestamps are expressed in **hours relative to admission**.

This repository contains:

- The **T2S2 corpus** of **2,139 Sepsis-3 PubMed Open Access (PMOA) case reports**
- **Clinician annotations** for gold-standard evaluation
- **LLM-generated annotations** across multiple model families
- Code for **event matching**, **temporal evaluation**, and **bootstrap analysis**
- Prompt ablations and robustness analyses used in the paper

T2S2 is intended as a retrospective research resource for **temporal modeling of clinical narratives**, including applications such as risk forecasting, disease trajectory characterization, and causal reasoning.

---

## Paper Summary

We construct a textual time series corpus for **Sepsis-3** by extracting **clinical findings and timestamps** from retrospective case reports.

The paper evaluates LLM-generated trajectories against clinician annotations using four metrics:

- **Event match rate** (semantic recovery of clinical findings)
- **Concordance (c-index)** for temporal ordering
- **Median absolute error (MAE)** for timestamp discrepancies
- **AULTC (Area Under the Log-Time Curve)** for time-scale-aware temporal accuracy

The released corpus includes:

| Dataset | Size | Purpose |
|----------|------|----------|
| `sepsis-40` | 40 reports | Clinician-annotated gold-standard evaluation |
| `sepsis-10` | 10 reports | Validation subset from `sepsis-40` for hallucination audit, clinician review, self-consistency, and onset analysis |
| `sepsis-100` | 100 reports | Bronze-standard proxy-reference evaluation |
| `t2s2_full_corpus` | 2,139 reports | Full Sepsis-3 PMOA textual time series corpus |

---

## Repository Structure

```text
.
├── annotations/
│   ├── sepsis-40/
│   ├── sepsis-10/
│   ├── sepsis-100/
│   ├── sepsis-40_ablations/
│   ├── sepsis-100_ablations/
│   ├── t2s2_full_corpus/
│   └── other_experiments/
│
├── compare_tts/
├── notebooks/
├── scripts/
├── results/
└── environment.yml
```

### `annotations/`

Contains released event–timestamp annotations and source case report text.

#### `sepsis-40/`
Clinician-annotated **gold-standard evaluation set** used in the main paper. Includes:

- Manual clinician annotations
- Model-generated annotations
- PMOA case report text bodies

#### `sepsis-10/`
A 10-report subset of `sepsis-40` used for:

- Clinician quality review
- Hallucination audit
- Multi-pass self-consistency of LLM annotations
- Sepsis onset analysis

#### `sepsis-100/`
A **bronze-standard proxy-reference evaluation set**, using GPT-5 annotations as reference for scalable evaluation beyond the clinician-annotated subset.

#### `sepsis-40_ablations/` and `sepsis-100_ablations/`
Prompt ablation experiments for **Llama-3.3-70B-Instruct**, including:

- No role-playing
- No conjunction expansion
- Zero-shot prompting
- Interval prompting
- Interval+i2b2 event typing augmentation

#### `t2s2_full_corpus/`
The full **2,139-report PMOA T2S2 corpus**, including:

- Case report body text
- Model-generated event–timestamp trajectories

### `compare_tts/`

Evaluation pipeline for comparing predicted textual time series against reference annotations.

Implements:

- Embedding-based event matching
- Recursive best matching
- Temporal concordance
- Median absolute error
- AULTC
- Bootstrap confidence intervals

### `notebooks/`

Analysis notebooks and utilities used for:

- Threshold sensitivity analyses
- Hallucination checks
- Metric inspection
- Figure generation

### `scripts/`

Scripts for generating event–timestamp annotations.

Includes:

- `make_annotations.py` — API-based annotation generation
- `make_local_annotations.py` — local Hugging Face model inference

### `results/`

Generated outputs from the evaluation pipeline:

- Matched event files
- Figures
- CSV metric summaries
- Bootstrap outputs

---

## Installation

Clone the repository and create the conda environment:

```bash
git clone https://github.com/Shahriarnz14/T2S2.git
cd T2S2

conda env create -f environment.yml
conda activate t2s2_env
```

The comparison pipeline uses both **Python** and **R**.

---

## Quick Start

### Run textual time-series comparison

Move to the comparison directory:

```bash
cd compare_tts
```

Run the main `sepsis-40` comparison:

```bash
./comparer_runner.sh config_t2s2_chil_camera_ready_sepsis40_greedy.json
```

The pipeline:

1. Starts a local embedding server (`uvicorn`)
2. Computes semantic event matching
3. Evaluates temporal ordering and timestamp accuracy
4. Writes outputs to `results/`

Additional configs:

```bash
./comparer_runner.sh config_t2s2_chil_camera_ready_sepsis100_greedy.json

./comparer_runner.sh config_t2s2_chil_camera_ready_sepsis40_ablations_greedy.json

./comparer_runner.sh config_t2s2_chil_camera_ready_sepsis100_ablations_greedy.json

./comparer_runner.sh config_t2s2_chil_t2s2_l33_greedy.json
```

Generated outputs are written to:

```text
results/
```

including:

- matched event files
- figures
- summary metrics
- `summary_metrics.csv`

---

## Bootstrap Confidence Intervals

Bootstrap confidence intervals can be generated after running the comparison pipeline.

From `compare_tts/`:

```bash
./bootstrap_runner.sh bootstrap_config_t2s2_chil_camera_ready_sepsis40_greedy.json

./bootstrap_runner.sh bootstrap_config_t2s2_chil_camera_ready_sepsis100_greedy.json
```

These scripts resample **case reports with replacement** and recompute evaluation metrics to estimate uncertainty.

---

## Generating New Annotations

Annotation scripts are provided under `scripts/`.

Before running them, replace placeholder paths and credentials with local values.

### API-based annotation

```bash
python scripts/make_annotations.py
```

### Local model annotation

```bash
python scripts/make_local_annotations.py
```

---

## Data Notes

### PMOA data

The PMOA-derived T2S2 case reports and annotations are included in this repository.

### i2m4 / MIMIC-IV

The i2m4 discharge summaries are **not redistributed** due to data-access restrictions associated with MIMIC/i2b2.
However, i2m4-related configs are included for reproducibility.

Access to MIMIC-IV can be obtained through PhysioNet:
https://physionet.org/content/mimiciv/3.1/

---

## Related Work: Forecasting from T2S2

T2S2 is used in the related downstream forecasting project:

**Forecasting Clinical Risk from Textual Time Series: Structuring Narratives for Temporal AI in Healthcare**

* AAAI 2026 Paper:
https://ojs.aaai.org/index.php/AAAI/article/view/41255

* Repository:
https://github.com/Shahriarnz14/Textual-Time-Series-Forecasting



---

## Citation

```bibtex
@inproceedings{noroozizadeh2026reconstructing,
  title={Reconstructing sepsis trajectories from clinical case reports using llms: the textual time series corpus for sepsis},
  author={Noroozizadeh, Shahriar and Weiss, Jeremy C},
  booktitle={Conference on Health, Inference, and Learning},
  year={2026},
  organization={PMLR},
  url={https://arxiv.org/abs/2504.12326}
}
```