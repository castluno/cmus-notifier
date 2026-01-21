#!/data/data/com.termux/files/usr/bin/bash
set -e

echo
echo 'uninstalling cmus-notifier...'

rm -rf "$HOME/.cn-dont-delete"

ALIAS='alias cn="bash ~/.cn-dont-delete/controller.sh"'

sed -i "\|$ALIAS|d" "$HOME/.bashrc"
sed -i "\|$ALIAS|d" "$HOME/.zshrc"

echo 'uninstalled. restart the terminal.'
echo
