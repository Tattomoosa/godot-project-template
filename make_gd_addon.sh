#!/bin/bash

PROJECT_DIR="$(pwd)"

if [[ $# -ne 2 ]]; then
  echo 'Usage: make_gd_addon [repo-root-folder] [addon-root]' >&2
  exit 2
fi

cd submodules
mkdir "$1"
cd "$1"
git init
mkdir -p "addons/$2"
cd addons
for f in *; do
  ln -s "$(pwd)/$f" "$PROJECT_DIR/addons/$f"
done

