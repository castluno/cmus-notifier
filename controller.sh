#!/data/data/com.termux/files/usr/bin/bash

script="$HOME/.cn-dont-delete/notifier.sh"
pidfile="$HOME/.cn-dont-delete/notifier.pid"

start() {
    if [[ -f "$pidfile" ]] && kill -0 "$(cat "$pidfile")" 2>/dev/null; then
        echo "Already running"
        exit 0
    fi

    (
        echo $$ > "$pidfile"
        echo "Started"

        trap 'cleanup' SIGINT SIGTERM

        cleanup() {
            echo "Stopping..."
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
        echo "Not running"
        exit 0
    fi

    pid=$(cat "$pidfile")
    kill "$pid" 2>/dev/null
    rm -f "$pidfile"
    echo "Stopped"
}

case "$1" in
    start) start ;;
    stop) stop ;;
    *)
        echo "Usage: cn {start|stop}"
    ;;
esac
