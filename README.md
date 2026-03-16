# LeRobot PushT Experiments
## ACT vs Diffusion Policy on PushT Task

WSL2 + RTX 4060 환경에서 LeRobot 라이브러리를 활용해
ACT와 Diffusion Policy 두 모방학습 모델을 동일 태스크에 적용하고 성능을 비교한 실험입니다.

---

## 실험 개요

| 항목 | 내용 |
|------|------|
| 태스크 | PushT — T블록을 목표 위치로 밀기 |
| 데이터셋 | lerobot/pusht (206 에피소드, 25,650 프레임) |
| 모델 | ACT, Diffusion Policy |
| 평가 지표 | Success Rate, Average Max Reward |
| 환경 | WSL2 Ubuntu 24.04, RTX 4060 Laptop, CUDA 12.4 |

---

## 실험 결과

### ACT (Action Chunking with Transformers)

| 학습 스텝 | Success Rate | Avg Max Reward | 학습 시간 |
|----------|-------------|----------------|----------|
| 100K | 0.0% | 0.391 | 1시간 49분 |
| 500K | 진행중 | - | - |

### Diffusion Policy

| 학습 스텝 | Success Rate | Avg Max Reward | 학습 시간 |
|----------|-------------|----------------|----------|
| 예정 | - | - | - |

---

## 평가 영상

### ACT 100K
![ACT 100K](results/act_100k/eval_episode_0.mp4)

---

## 모델 설명

### ACT (Action Chunking with Transformers)
- Stanford 2023 발표
- Transformer 기반으로 앞으로 100개 행동을 한꺼번에 예측 (Action Chunking)
- 빠른 실시간 제어에 적합

### Diffusion Policy
- MIT + Columbia 2023 발표
- 확산 모델 기반으로 노이즈에서 행동을 생성
- 복잡한 동작 패턴 표현에 강점

---

## 환경 설정

### 설치 (한 번에)
```bash
bash scripts/setup_lerobot.sh
```

### 학습 실행
```bash
# ACT
python -m lerobot.scripts.lerobot_train \
  --policy.type=act \
  --env.type=pusht \
  --dataset.repo_id=lerobot/pusht \
  --output_dir=outputs/train/act_pusht \
  --policy.push_to_hub=false \
  --dataset.video_backend=pyav \
  --steps=500000

# Diffusion Policy
python -m lerobot.scripts.lerobot_train \
  --policy.type=diffusion \
  --env.type=pusht \
  --dataset.repo_id=lerobot/pusht \
  --output_dir=outputs/train/diffusion_pusht \
  --policy.push_to_hub=false \
  --dataset.video_backend=pyav \
  --steps=500000
```

---

## 주요 트러블슈팅

WSL2 환경 특이사항으로 인한 설치 이슈 및 해결법은
[docs/troubleshooting.md](docs/troubleshooting.md) 참고

---

## References
- [LeRobot](https://github.com/huggingface/lerobot)
- [ACT Paper](https://arxiv.org/abs/2304.13705)
- [Diffusion Policy Paper](https://arxiv.org/abs/2303.04137)
