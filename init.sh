#!/bin/sh

if [ $# -eq 0 ]; then
  echo 'Please input <project-name>'
  exit
fi

PROJECT_NAME=$1
BASEDIR=$(dirname "$0")

echo 'create project:' $PROJECT_NAME '...'

# === init ===
mix phoenix.new $PROJECT_NAME --no-brunch --no-ecto --database mysql
echo "# Vim\n*~\n*swp" >> $PROJECT_NAME/.gitignore

# === git ===
cd $PROJECT_NAME
git init; git add .; git commit -m 'init'

# === done ===
echo "\n\ndone!"
