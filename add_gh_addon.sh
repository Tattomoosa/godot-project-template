#!/bin/bash
set -x
echo $1

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DIR=${1#*/}
cd submodules
git submodule add git@github.com:$1.git $DIR
cd $DIR/addons
ls -a
for f in *; do
  pwd
  echo "$f"
  ln -s "$(pwd)/$f" "$SCRIPT_DIR/addons/$f"
done

set +x

