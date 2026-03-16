#!/bin/bash
set -e

echo "=== 1. conda 환경 생성 (Python 3.12 + FFmpeg 7) ==="
conda create -n lerobot python=3.12 "ffmpeg=7.*" -c conda-forge -y

echo "=== 2. 환경 활성화 ==="
source ~/miniconda3/etc/profile.d/conda.sh
conda activate lerobot

echo "=== 3. PyTorch + CUDA 설치 ==="
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124

echo "=== 4. LeRobot 클론 ==="
cd ~
git clone https://github.com/huggingface/lerobot.git
cd lerobot

echo "=== 5. 문제 패키지 사전 제거 ==="
pip install evdev-binary
pip install pynput --no-deps
sed -i '/pynput/d' pyproject.toml
sed -i '/torchcodec/d' pyproject.toml

echo "=== 6. LeRobot + pusht 설치 ==="
pip install -e ".[pusht]"

echo "=== 7. 설치 확인 ==="
python -c "import torch; print('CUDA:', torch.cuda.is_available())"
python -c "import lerobot; print('LeRobot:', lerobot.__version__)"

echo "=== 완료! ==="
