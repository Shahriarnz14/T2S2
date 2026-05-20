#!/bin/bash

mkdir -p /data/weissjc/workspace/T2S2/t2s2/DeepSeek-R1-UD-IQ1_S_annotations/clean2
for file in /data/weissjc/workspace/T2S2/t2s2/DeepSeek-R1-UD-IQ1_S_annotations/clean/*; do
    awk -F'|' 'NF==2' "$file" > "/data/weissjc/workspace/T2S2/t2s2/DeepSeek-R1-UD-IQ1_S_annotations/clean2/$(basename "$file")"
done