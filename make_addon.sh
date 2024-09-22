#!/bin/bash

PROJECT_DIR="$(pwd)"

if [[ $# -ne 1 ]]; then
  echo 'Usage: make_gd_addon [repo]' >&2
  exit 2
fi

cd submodules
mkdir -p "$1"
cd "$1"
git init

echo "config_version=5" >> "project.godot"
echo "[debug]" >> "project.godot"
echo "" >> "project.godot"
echo "gdscript/warnings/exclude_addons=false" >> "project.godot"
echo "gdscript/warnings/untyped_declaration=1" >> "project.godot"
echo "gdscript/warnings/unsafe_property_access=1" >> "project.godot"
echo "gdscript/warnings/unsafe_method_access=1" >> "project.godot"
echo "gdscript/warnings/return_value_discarded=1" >> "project.godot"

mkdir -p "addons/$1"

cd addons/$1

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

cd ../..

for author in *; do
  mkdir "$PROJECT_DIR/addons/$author"
  cd "$author"
  ls
  for repo in *; do
    echo ln -s "$(pwd)/$author/$repo" "$PROJECT_DIR/addons/$author/$repo"
    ln -s "$(pwd)/$repo" "$PROJECT_DIR/addons/$author/$repo"
  done
  cd ..
done


