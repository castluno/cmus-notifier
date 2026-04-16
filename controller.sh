#!/data/data/com.termux/files/usr/bin/bash

script="$HOME/.cn-dont-delete/notifier.sh"
pidfile="$HOME/.cn-dont-delete/cn.pid"

start() {
    if [[ -f "$pidfile" ]] && kill -0 "$(cat "$pidfile")" 2>/dev/null; then
        echo "already running"
        exit 0
    fi

    (
        echo $(($$ + 1)) > "$pidfile"
        echo "started"

        trap 'cleanup' SIGINT SIGTERM

        cleanup() {
            [[ -n "$child" ]] && kill "$child" 2>/dev/null
            rm -f "$pidfile"
            exit 0
        }

        while true; do
            bash "$script" &
            child=$!

            for ((i=0; i<30; i++)); do
                sleep 1
            done

            kill "$child" 2>/dev/null
        done
    ) &
}

stop() {
    if [[ ! -f "$pidfile" ]]; then
        echo "not running"
        exit 0
    fi

    pid=$(cat "$pidfile")
    kill "$pid" 2>/dev/null
    rm -f "$pidfile"
    echo "stopped"
}

case "$1" in
    start) start ;;
    stop) stop ;;
    *)
        echo "usage: cn {start|stop}"
        echo "v0.2.1"
    ;;
esac
