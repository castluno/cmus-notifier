#!/data/data/com.termux/files/usr/bin/bash
set -e

echo
echo 'installing cmus-notifier...'
echo

if [ ! -d /data/data/com.termux ]; then
  echo 'this installer is for termux only :('
  echo
  exit 1
fi

# installing packages
pkg install -y cmus git termux-api

rm -rf cmus-notifier
git clone https://github.com/castluno/cmus-notifier

mkdir -p "$HOME/.cn-dont-delete"

# cloning files from the repository
chmod +x "cmus-notifier/controller.sh"
chmod +x "cmus-notifier/notifier.sh"
cp "cmus-notifier/controller.sh" "$PREFIX/bin/cn"
cp "cmus-notifier/notifier.sh" "$HOME/.cn-dont-delete"
cp "cmus-notifier/readme_indir.txt" "$HOME/.cn-dont-delete/readme.txt"

rm -rf "cmus-notifier"

echo
echo 'cmus-notifier is installed. do not delete ~/.cn-dont-delete - the program files are located here.'
echo 'type "cn" to start using program'
echo