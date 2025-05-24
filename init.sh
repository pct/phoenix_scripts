#!/bin/sh
# Phoenix 專案初始化腳本（自動保持 Hex 與 phx_new 最新）

if [ $# -eq 0 ]; then
  echo 'Please input <project-name>'
  exit 1
fi

PROJECT_NAME=$1
BASEDIR=$(dirname "$0")

# === Always update Hex and Phoenix installer ===
echo '=== Updating Hex and Phoenix installer ==='
mix local.hex --force
mix archive.install --force hex phx_new

# === Create Phoenix project ===
echo "=== Creating project: $PROJECT_NAME ==="
mix phx.new $PROJECT_NAME --database mysql --no-install

echo -e "# Vim\n*~\n*.swp" >> $PROJECT_NAME/.gitignore

# === Copy scripts/config if present ===
[ -d "$BASEDIR/scripts" ] && cp -rpf "$BASEDIR/scripts" "$PROJECT_NAME/priv"
[ -d "$BASEDIR/config" ] && cp -rpf "$BASEDIR/config" "$PROJECT_NAME/config"

# === Git init ===
cd "$PROJECT_NAME"
git init
 git add .
git commit -m 'init'

# === Done ===
echo "\n=== DONE ===\n"
echo "Project '$PROJECT_NAME' created! Next steps:"
echo "[1] cd $PROJECT_NAME"
echo "[2] edit config/dev.exs for DB settings"
echo "[3] mix deps.get && mix ecto.create"
echo "[4] mix phx.server"
