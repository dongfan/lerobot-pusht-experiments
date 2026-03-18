# genesis-franka-portfolio

ACT(모방학습) + SAC(강화학습) + Genesis(디지털트윈) 통합 포트폴리오

## 프로젝트 구조
```
genesis-franka-portfolio/
├── envs/
│   └── genesis_robot_env.py   # GenesisRobotEnv (gym.Env)
├── scripts/
│   ├── train_sac.py           # SAC 강화학습
│   └── train_act.py           # ACT 모방학습 (lerobot 연동)
├── notebooks/
│   └── sim_to_real.ipynb      # 디지털 트윈 분석
└── results/                   # 학습 결과 저장
```

## conda 환경
- `lerobot` — ACT 모방학습
- `genesis` — Genesis 물리 시뮬레이터
- `rl` — SAC 강화학습

## 목표
Franka Panda 로봇팔로 박스 밀기 태스크를 ACT와 SAC로 각각 학습,
Genesis 시뮬레이터에서 검증하는 Sim-to-Real 포트폴리오 완성
