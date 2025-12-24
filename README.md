# 🎧 MOODY MUSIC

MOODY MUSIC is a **distributed, master–worker Discord music platform** built for
**large-scale public usage**, capable of running **up to 100 worker bots simultaneously**.

It is not a single bot — it is a **music infrastructure**.

---

## 🚀 Key Highlights

- 🧠 **Master–Worker Architecture**
- 🤖 **Up to 100 Worker Bots**
- 🔊 Lavalink-based high quality streaming
- 🧱 Redis as single source of truth
- 🎭 Per-guild worker avatars (Premium)
- 🎤 Lyrics + Karaoke mode
- 🌍 Multi-VC streaming per guild
- 💎 Premium plans (5 / 15 / 30 workers)
- 💳 Stripe + Razorpay billing
- 🌐 Website dashboard & admin panel
- 🐳 Docker + Kubernetes ready

---

## 🧠 Architecture Overview

Discord Users
│
▼
MASTER BOT (Control Plane)
│
Redis (State, Locks, Queues)
│
WORKER BOT POOL (1–100)
│
Lavalink Cluster


- **Master Bot** handles all commands & permissions
- **Worker Bots** only play audio
- **Workers cannot operate without the Master**

---

## 🧩 Repository Structure



master/ → Discord command brain
worker/ → Lavalink audio executors
website/ → Dashboard + billing
lavalink/ → Audio engine
deploy/ → Docker + Kubernetes
docs/ → Architecture & ops


---

## 🛠 Requirements

- Python 3.10+
- Java 17+
- Node.js 18+
- Redis
- Docker (recommended)

---

## ▶️ Quick Start (Local)

```bash
redis-server
java -jar Lavalink.jar
python master/main.py
python worker/main.py

📄 Documentation

docs/ARCHITECTURE.md

docs/PREMIUM_PLANS.md

docs/DEPLOYMENT.md

🧑‍💻 License

MIT License © MOODY MUSIC


---

# 2️⃣ `docs/ARCHITECTURE.md`

```md
# 🧠 MOODY MUSIC — SYSTEM ARCHITECTURE

MOODY MUSIC is a **distributed Discord music system** designed to scale horizontally.

---

## Core Principle

> Worker bots **never operate independently**.  
> The **Master Bot is mandatory** in every guild.

---

## Logical Components

### 🧠 Master Bot
- Handles all Discord commands
- Enforces premium limits
- Assigns workers
- Controls scaling
- Talks only to Redis

### 🤖 Worker Bots
- Join voice channels
- Connect to Lavalink
- Play audio
- Handle multiple VCs
- Stateless & disposable

### 🔊 Lavalink
- Audio processing
- Independent scaling
- Load-balanced by workers

### 🧱 Redis
- Global state
- Playback queues
- Worker health
- Premium status
- Locks & recovery

---

## Worker Lifecycle



Worker starts
→ Heartbeat to Redis
→ Assigned by Master
→ Joins VC
→ Streams audio
→ Crash? Reassigned


---

## Failure Handling

| Failure | Result |
|------|------|
Worker crash | Auto reassigned |
Master crash | Workers pause |
Redis down | REST fallback |
Lavalink down | Node switch |

---

## Scaling Strategy

- Start with 5–10 workers
- Add workers horizontally
- No downtime
- Master does not scale vertically

---

## Why This Works

- No Discord rate-limit abuse
- No single point of failure
- Safe for 100+ workers
- Monetization-friendly

3️⃣ CI/CD — GitHub Actions
.github/workflows/docker.yml
name: Build Docker Images

on:
  push:
    branches: [ "main" ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3

    - name: Login to Docker Hub
      uses: docker/login-action@v2
      with:
        username: ${{ secrets.DOCKER_USER }}
        password: ${{ secrets.DOCKER_PASS }}

    - name: Build & Push Master
      run: |
        docker build -t moody/master ./master
        docker push moody/master

    - name: Build & Push Worker
      run: |
        docker build -t moody/worker ./worker
        docker push moody/worker

.github/workflows/deploy.yml
name: Deploy to Kubernetes

on:
  workflow_run:
    workflows: ["Build Docker Images"]
    types: [completed]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3

    - name: Set kubeconfig
      run: |
        echo "${{ secrets.KUBE_CONFIG }}" > ~/.kube/config

    - name: Apply manifests
      run: |
        kubectl apply -f deploy/k8s/

4️⃣ FULL DOCKER MANIFESTS
deploy/docker-compose.yml
version: "3.9"

services:
  redis:
    image: redis:7
    restart: always

  lavalink:
    image: fredboat/lavalink
    volumes:
      - ../lavalink/application.yml:/opt/Lavalink/application.yml
    ports:
      - "2333:2333"

  master:
    image: moody/master
    env_file: ../.env
    depends_on:
      - redis
      - lavalink

  worker:
    image: moody/worker
    env_file: ../.env
    depends_on:
      - redis
      - lavalink
    deploy:
      replicas: 5

Kubernetes — deploy/k8s/worker.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: moody-worker
spec:
  replicas: 30
  selector:
    matchLabels:
      app: worker
  template:
    metadata:
      labels:
        app: worker
    spec:
      containers:
      - name: worker
        image: moody/worker
        envFrom:
          - secretRef:
              name: moody-env


Scale anytime:

kubectl scale deployment moody-worker --replicas=100

5️⃣ FINAL PRODUCTION CHECKLIST
✅ PRE-LAUNCH

 Master bot verified & sharded

 All worker tokens stored securely

 Redis persistence enabled

 Lavalink multi-node setup

 Stripe & Razorpay webhooks verified

 Premium enforcement tested

 Downgrade grace logic verified

 Admin dashboard secured

 Rate limits tested

 Logging & alerts enabled

✅ LAUNCH

 Invite Master bot only

 Enable auto-invite bundles

 Monitor worker health

 Enable CI/CD

 Enable backups

✅ POST-LAUNCH

 Scale workers gradually

 Monitor CPU & bandwidth

 Rotate tokens periodically

 Review audit logs

 Optimize Lavalink nodes

🏁 FINAL WORD

You now have:

✔ A commercial-grade Discord music platform
✔ Full architecture & documentation
✔ CI/CD & deployment automation
✔ Scaling to 100 worker bots
✔ Monetization-ready system

This is far beyond a typical Discord bot.
