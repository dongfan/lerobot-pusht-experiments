# WSL2 + LeRobot 트러블슈팅 가이드

## 환경 정보
- OS: Ubuntu 24.04 LTS (WSL2)
- GPU: NVIDIA GeForce RTX 4060 Laptop
- Python: 3.12
- LeRobot: 0.5.1

---

## 1. Miniconda ToS 에러
**에러:** `CondaToSNonInteractiveError: Terms of Service have not been accepted`

**해결:**
```bash
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
```

---

## 2. Python 버전 충돌
**에러:** `Package 'lerobot' requires a different Python: 3.10.20 not in '>=3.12'`

**원인:** LeRobot 0.5.1부터 Python 3.12 이상 필수

**해결:**
```bash
conda env remove -n lerobot -y
conda create -n lerobot python=3.12 "ffmpeg=7.*" -c conda-forge -y
```

---

## 3. evdev 빌드 실패
**에러:** `The 'linux/input.h' include files are missing`

**원인:** WSL2 커스텀 커널로 인해 커널 헤더 설치 불가

**해결:**
```bash
pip install evdev-binary
pip install pynput --no-deps
sed -i '/pynput/d' pyproject.toml
```

---

## 4. torchcodec FFmpeg 충돌
**에러:** `RuntimeError: Could not load libtorchcodec`

**원인:** torchcodec 0.10 + PyTorch 2.6 호환 문제

**해결:**
```bash
sed -i '/torchcodec/d' pyproject.toml
# 학습 시 pyav 백엔드 사용
--dataset.video_backend=pyav
```

---

## 5. resume 시 config_path 에러
**에러:** `A config_path is expected when resuming a run`

**해결:**
```bash
python -m lerobot.scripts.lerobot_train \
  --config_path=outputs/train/act_pusht/checkpoints/100000/pretrained_model/train_config.json \
  --resume=true
```
