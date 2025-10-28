#!/bin/bash
exec > >(tee -a /workspace/output/progress.txt) 2>&1
set -e

export nnUNet_raw="/workspace/input/nnUNet_raw"
export nnUNet_preprocessed="/workspace/output/nnUNet_preprocessed"
export nnUNet_results="/workspace/output/nnUNet_weights"

echo "[INFO] Starting nnU-Net AbdomenCT-1K baseline training..."
date

# only preprocess if the preprocessed folder doesnt already exist or is empty
if [ ! -d "$nnUNet_preprocessed/Dataset101_AbdomenCT1K" ] || [ -z "$(ls -A "$nnUNet_preprocessed/Dataset101_AbdomenCT1K" 2>/dev/null)" ]; then
    echo "[INFO] Preprocessed data not found. Running preprocessing..."
    nnUNetv2_plan_and_preprocess -d 101 -c "3d_fullres" --verify_dataset_integrity
else
    echo "[INFO] Preprocessed data found. Skipping preprocessing."
fi

for fold in 0 1 2 3 4; do
    echo "[INFO] Training fold $fold..."
    nnUNetv2_train "Dataset101_AbdomenCT1K" "3d_fullres" $fold --npz
done

echo "[INFO] Training complete."
date

echo "[INFO] Aggregating k fold outputs."
nnUNetv2_find_best_configuration 101 -c "3d_fullres"

# echo "[INFO] Training complete. Running post-job script..."
# python3.12 main.py - we dont have to run main.py for now
echo "[INFO] Done."
