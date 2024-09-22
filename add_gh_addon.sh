#!/bin/bash
set -x

if [[ $# -ne 1 ]]; then
  echo 'Usage: ./add_gd_addon.sh [gh-repo]' >&2
  exit 2
fi

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
# SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR="$(pwd)"

# DIR=${1#*/}
cd submodules
# echo "${1%%/*}"
mkdir -p "${1%%/*}"
git submodule add "git@github.com:$1.git" "$1"
cd $1/addons
for f in *; do
  ln -s "$(pwd)/$f" "$PROJECT_DIR/addons/$f"
done
