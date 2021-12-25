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
mix archive.install hex phx_new

# === init ===
echo '=== create project:' $PROJECT_NAME '==='
mix phx.new $PROJECT_NAME --database mysql
echo "# Vim\n*~\n*swp" >> $PROJECT_NAME/.gitignore

# === copy scripts ===

cp -rpf $BASEDIR/scripts $PROJECT_NAME/priv

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
echo "[4] use 'mix phx.server' to start phoenix server"
