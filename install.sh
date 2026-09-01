#!/data/data/com.termux/files/usr/bin/bash
set -e

TMP="$HOME/.cn-tmp"
CN="$HOME/.cn-dont-delete"

echo
echo "installing cmus-notifier..."
echo

if [ ! -d /data/data/com.termux ]; then
  echo 'this installer is for termux only :('
  echo
  exit 1
fi

# installing packages
pkg install -y cmus git termux-api

rm -rf $TMP
git clone https://github.com/castluno/cmus-notifier $TMP

mkdir -p $CN

# cloning files from the repository
chmod +x "$TMP/controller.sh"
chmod +x "$TMP/notifier.sh"
cp "$TMP/controller.sh" "$PREFIX/bin/cn"
cp "$TMP/notifier.sh" "$CN/"
cp "$TMP/readme_indir.txt" "$CN/readme.txt"

rm -rf $TMP

echo
echo 'cmus-notifier is installed. do not delete ~/.cn-dont-delete - the program files are located here.'
echo 'type "cn" to start using program'
echo
