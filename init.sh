#!/bin/sh

if [ $# -eq 0 ]; then
  echo 'Please input <project-name>'
  exit
fi

PROJECT_NAME=$1
BASEDIR=$(dirname "$0")

# === install/upgrade hex ===
echo '=== install/upgrade hex ==='
mix local.hex

# === init ===
echo '=== create project:' $PROJECT_NAME '==='
mix phx.new $PROJECT_NAME
echo "# Vim\n*~\n*swp" >> $PROJECT_NAME/.gitignore

# === git ===
cd $PROJECT_NAME
git init; git add .; git commit -m 'init'

# === phxauth ===
mix archive.install https://github.com/riverrun/phauxth_installer/raw/master/archives/phauxth_new.ez
mix phauxth.new --confirm --remember --no-backups
mix deps.get


# === done ===
echo "=== done ==="
echo "\n\n"
echo "Projejct '$PROJECT_NAME' created! You could:"
echo "[1] cd $PROJECT_NAME"
echo "[2] edit 'config/dev.exs' for development db settings"
echo "[3] use 'mix ecto.create' to create development db"
echo "[4] use 'mix phx.server' to start phoenix server"
