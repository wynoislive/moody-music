@echo off
SET ROOT=moody-music

echo Creating directory structure for %ROOT%...

:: Root Files
mkdir "%ROOT%"
type nul > "%ROOT%\README.md"
type nul > "%ROOT%\LICENSE"
type nul > "%ROOT%\.gitignore"
type nul > "%ROOT%\.env.example"

:: Docs
mkdir "%ROOT%\docs"
type nul > "%ROOT%\docs\ARCHITECTURE.md"
type nul > "%ROOT%\docs\REDIS_KEYS.md"
type nul > "%ROOT%\docs\PREMIUM_PLANS.md"
type nul > "%ROOT%\docs\DEPLOYMENT.md"
type nul > "%ROOT%\docs\SECURITY.md"

:: Master
mkdir "%ROOT%\master"
type nul > "%ROOT%\master\main.py"
type nul > "%ROOT%\master\config.py"
type nul > "%ROOT%\master\redis.py"
type nul > "%ROOT%\master\assign.py"
type nul > "%ROOT%\master\limits.py"
type nul > "%ROOT%\master\premium_ui.py"
type nul > "%ROOT%\master\ai_autoplay.py"
type nul > "%ROOT%\master\resolvers.py"
type nul > "%ROOT%\master\recovery.py"
type nul > "%ROOT%\master\requirements.txt"
type nul > "%ROOT%\master\Dockerfile"

:: Worker
mkdir "%ROOT%\worker"
type nul > "%ROOT%\worker\main.py"
type nul > "%ROOT%\worker\config.py"
type nul > "%ROOT%\worker\redis.py"
type nul > "%ROOT%\worker\playback.py"
type nul > "%ROOT%\worker\lyrics.py"
type nul > "%ROOT%\worker\heartbeat.py"
type nul > "%ROOT%\worker\requirements.txt"
type nul > "%ROOT%\worker\Dockerfile"

:: Website (Backend & Frontend)
mkdir "%ROOT%\website\backend"
type nul > "%ROOT%\website\backend\app.py"
type nul > "%ROOT%\website\backend\billing.py"
type nul > "%ROOT%\website\backend\admin.py"
type nul > "%ROOT%\website\backend\workers.py"
type nul > "%ROOT%\website\backend\auth.py"
type nul > "%ROOT%\website\backend\requirements.txt"
type nul > "%ROOT%\website\backend\Dockerfile"

mkdir "%ROOT%\website\frontend\src\pages"
mkdir "%ROOT%\website\frontend\src\components"
mkdir "%ROOT%\website\frontend\src\styles"
type nul > "%ROOT%\website\frontend\package.json"
type nul > "%ROOT%\website\frontend\vite.config.js"
type nul > "%ROOT%\website\frontend\src\main.jsx"
type nul > "%ROOT%\website\frontend\src\api.js"
type nul > "%ROOT%\website\frontend\src\pages\Workers.jsx"
type nul > "%ROOT%\website\frontend\src\pages\Admin.jsx"
type nul > "%ROOT%\website\frontend\src\pages\Premium.jsx"
type nul > "%ROOT%\website\frontend\src\pages\Login.jsx"
type nul > "%ROOT%\website\frontend\src\components\WorkerCard.jsx"
type nul > "%ROOT%\website\frontend\src\components\StatusBadge.jsx"
type nul > "%ROOT%\website\frontend\src\components\BundleInvite.jsx"
type nul > "%ROOT%\website\frontend\src\components\Charts.jsx"
type nul > "%ROOT%\website\frontend\src\styles\app.css"

:: Lavalink
mkdir "%ROOT%\lavalink"
type nul > "%ROOT%\lavalink\application.yml"
type nul > "%ROOT%\lavalink\README.md"

:: Deploy (K8s & Scripts)
mkdir "%ROOT%\deploy\k8s"
mkdir "%ROOT%\deploy\scripts"
type nul > "%ROOT%\deploy\docker-compose.yml"
type nul > "%ROOT%\deploy\k8s\redis.yaml"
type nul > "%ROOT%\deploy\k8s\lavalink.yaml"
type nul > "%ROOT%\deploy\k8s\master.yaml"
type nul > "%ROOT%\deploy\k8s\worker.yaml"
type nul > "%ROOT%\deploy\k8s\ingress.yaml"
type nul > "%ROOT%\deploy\scripts\start-local.sh"
type nul > "%ROOT%\deploy\scripts\scale-workers.sh"
type nul > "%ROOT%\deploy\scripts\rotate-tokens.sh"

:: GitHub Workflows
mkdir "%ROOT%\.github\workflows"
type nul > "%ROOT%\.github\workflows\docker.yml"
type nul > "%ROOT%\.github\workflows\deploy.yml"
type nul > "%ROOT%\.github\ISSUE_TEMPLATE.md"

echo Done! Project structure created in /%ROOT%
pause
