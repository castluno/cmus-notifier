# cmus-notifier

background notification controller for cmus in Termux.


##### features
- persistent notification with track info
- progress bar
- playback control buttons
- auto-restart daemon
- one-line install

##### requirements
- termux
- `bash`
- `cmus`
- `termux-api`


##### installation, usage and uninstallation

install:
`curl -fsSL https://raw.githubusercontent.com/castluno/cmus-notifier/main/install.sh | bash`

cmus-notifier also requires Termux:API to work. the library installs the install.sh, but the application must be downloaded separately here: [Termux:API](https://github.com/termux/termux-api/releases/latest)


start/stop:
`cn start` `cn stop`

uninstall:
`curl -fsSL https://raw.githubusercontent.com/castluno/cmus-notifier/main/uninstall.sh | bash`


##### license
MIT

[![Termux](https://img.shields.io/badge/termux-supported-brightgreen)]()