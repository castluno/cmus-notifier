#!/data/data/com.termux/files/usr/bin/bash
set -e

echo
echo 'uninstalling cmus-notifier...'

rm -rf "$HOME/.cn-dont-delete"
rm "$PREFIX/bin/cn"

echo 'uninstalled.'
echo