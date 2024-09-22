#!/bin/bash

PROJECT_DIR="$(pwd)"

if [[ $# -ne 2 ]]; then
  echo 'Usage: make_gd_addon [repo] [addon-root]' >&2
  exit 2
fi

cd submodules
mkdir -p "$1"
cd "$1"
git init
mkdir -p "addons/$2"

cd addons/$2

# make some files
echo "[plugin]" >> "plugin.cfg"
echo "name=\"${1#*/}\"" >> "plugin.cfg"
echo "description=\"\"" >> "plugin.cfg"
echo "author=\"${1%%/*}\"" >> "plugin.cfg"
echo "version=\"0.1.0\"" >> "plugin.cfg"
echo "script=\"plugin.gd\"" >> "plugin.cfg"

echo "@tool" >> "plugin.gd"
echo "extends EditorPlugin" >> "plugin.gd"
echo "" >> "plugin.gd"
echo "func _enter_tree():" >> "plugin.gd"
echo "  pass" >> "plugin.gd"
echo "" >> "plugin.gd"
echo "func _exit_tree():" >> "plugin.gd"
echo "  pass" >> "plugin.gd"

mkdir src
mkdir media

cd ..

for f in *; do
  ln -s "$(pwd)/$f" "$PROJECT_DIR/addons/$f"
done


