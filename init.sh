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
mix phoenix.new $PROJECT_NAME --database mysql
echo "# Vim\n*~\n*swp" >> $PROJECT_NAME/.gitignore

# === git ===
cd $PROJECT_NAME
git init; git add .; git commit -m 'init'

# === done ===
echo "=== done ==="
echo "\n\n"
echo "Projejct '$PROJECT_NAME' created! You could:"
echo "[1] cd $PROJECT_NAME"
echo "[2] edit 'config/dev.exs' for development db settings"
echo "[3] use 'mix ecto.create' to create development db"
echo "[4] use 'mix phoenix.server' to start phoenix server"
