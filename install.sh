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
pkg install -y cmus git

rm -rf cmus-notifier
git clone https://github.com/castluno/cmus-notifier

mkdir -p "$HOME/.cn-dont-delete"

# cloning files from the repository
cp "cmus-notifier/controller.sh" "$HOME/.cn-dont-delete"
cp "cmus-notifier/notifier.sh" "$HOME/.cn-dont-delete"
cp "cmus-notifier/.readme-indir.txt" "$HOME/.cn-dont-delete/readme.txt"

rm -rf "cmus-notifier"

#writing a startup command in .bashrc and .zshrc
touch "$HOME/.bashrc" "$HOME/.zshrc"
ALIAS_LINE='alias cn="bash ~/.cn-dont-delete/controller.sh"'
grep -qxF "$ALIAS_LINE" "$HOME/.bashrc" || echo "$ALIAS_LINE" >> "$HOME/.bashrc"
grep -qxF "$ALIAS_LINE" "$HOME/.zshrc" || echo "$ALIAS_LINE" >> "$HOME/.zshrc"

if [[ "$SHELL" == *"zsh"* ]]; then
  echo 'restart your terminal or type "source ~/.zshrc"'
  echo
else
  echo 'restart your terminal or type "source ~/.bashrc"'
  echo
fi

echo
echo 'cmus-notifier is installed. do not delete ~/.cn-dont-delete - the program files are located here.'
echo 'type "cn" to start using program'
echo