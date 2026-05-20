#!/bin/bash
# source ~/anaconda3/etc/profile.d/conda.sh
# conda activate t2s2_env

# Parameters:
# $1 = config (default: /data/weissjc/tta/scripts/compare_tts/config_simple.json)
# $2 = CUDA_VISIBLE_DEVICES (default: 5)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG=${1:-"${SCRIPT_DIR}/config.json"}
CUDA_DEVICE=${2:-0}
# PORT=${3:-8000}

CUDA_VISIBLE_DEVICES=$CUDA_DEVICE PYTHONPATH="${SCRIPT_DIR}" uvicorn run_st_server:app --host localhost & # --port $PORT &
UVICORN_PID=$!

Rscript "${SCRIPT_DIR}/compare_tts.r" "$CONFIG"

# Kill the Uvicorn process after Rscript completes
kill $UVICORN_PID
