#!/bin/bash
# source ~/anaconda3/etc/profile.d/conda.sh
# conda activate clinical_annot

# Parameters:
# $1 = config (default: /data/weissjc/tta/scripts/compare_tts/config_simple.json)
# $2 = CUDA_VISIBLE_DEVICES (default: 5)
CONFIG=${1:-/mnt/c/Research/t2s2/compare_tts/config.json}
CUDA_DEVICE=${2:-0}
# PORT=${3:-8000}

CUDA_VISIBLE_DEVICES=$CUDA_DEVICE PYTHONPATH=/mnt/c/Research/t2s2/compare_tts/ uvicorn run_st_server:app --host localhost & # --port $PORT &
UVICORN_PID=$!

Rscript /mnt/c/Research/t2s2/compare_tts/compare_tts.r "$CONFIG"

# Kill the Uvicorn process after Rscript completes
kill $UVICORN_PID