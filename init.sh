#!/bin/sh

if [ $# -eq 0 ]; then
  echo 'Please input <project-name>'
  exit
fi

PROJECT_NAME=$1
BASEDIR=$(dirname "$0")

# === install/upgrade hex ===
mix local.hex

# === init ===
echo 'create project:' $PROJECT_NAME '...'
mix phoenix.new $PROJECT_NAME --database mysql
echo "# Vim\n*~\n*swp" >> $PROJECT_NAME/.gitignore

# === git ===
cd $PROJECT_NAME
git init; git add .; git commit -m 'init'

# === done ===
echo "\n\nYou could go 'cd $PROJECT_NAME; mix phoenix.server' now!"
