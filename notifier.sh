#!/data/data/com.termux/files/usr/bin/bash

# configuration
ID=9685
BAR_LENGTH=20 # scale length (in symbols)
UPDATE_INTERVAL=3 # notification update interval (default: 3)
EXID=4728

PREV_TEXT='Prev'
PAUS_TEXT='Pause/Play'
NEXT_TEXT='Next'

start_time=$(date +%s)

while true; do
    INFO=$(cmus-remote -Q 2>/dev/null)
    if [ $? -ne 0 ]; then

        termux-notification \
            --alert-once --ongoing --priority max --id $ID \
            --icon music_note \
            --title "cmus" \
            --content "cmus is not running"

        sleep $UPDATE_INTERVAL
        continue
    fi

    title=$(echo "$INFO" | grep '^tag title ' | cut -d ' ' -f 3-)
    artist=$(echo "$INFO" | grep '^tag artist ' | cut -d ' ' -f 3-)
    album=$(echo "$INFO" | grep '^tag album ' | cut -d ' ' -f 3-)
    position=$(echo "$INFO" | grep '^position ' | cut -d ' ' -f 2)
    duration=$(echo "$INFO" | grep '^duration ' | cut -d ' ' -f 2)
    status=$(echo "$INFO" | grep '^status ' | awk '{print $2}')

    fmt_time() {
        local s=$1
        [ -z "$s" ] && echo "0:00" && return
        printf "%d:%02d" $((s / 60)) $((s % 60))
    }

    pos_fmt=$(fmt_time "$position")
    dur_fmt=$(fmt_time "$duration")

    if [ -n "$duration" ] && [ "$duration" -gt 0 ]; then
        filled=$((BAR_LENGTH * position / duration))
        empty=$((BAR_LENGTH - filled))
        bar=$(printf "%0.s█" $(seq 1 $filled))$(printf "%0.s░" $(seq 1 $empty))
    else
        bar="(no data)"
    fi

    case "$status" in
        playing) icon="music_note";;         # notification icon when music is playing
        paused) icon="pause_circle_filled";; # notification icon when music is paused
        stopped) icon="stop_circle";;        # notification icon when music is stopped
        *) icon="music_note";;               # notification icon when the script has not received enough information
    esac

    content1="$artist - $album"
    content2="$bar $pos_fmt/$dur_fmt"

    #cmd="termux-notification --icon $icon --alert-once --ongoing --id $EXID --title '$title' --content $'$notif_content' --button1 '$PREV_TEXT' --button2 '$PAUSE_TEXT' --button3 '$NEXT_TEXT' --button1-action 'cmus-remote --prev' --button2-action 'cmus-remote --pause' --button3-action 'cmus-remote --next' --priority max"
    #eval "$cmd"

    # выше закомментирован старый и опасный метод вывода уведомления, которые более не обновляется.
    # опасный он потому, что если автор трека укажет в названии опасную команду,
    # то она выполнится, и может повредить ваши файлы. а ещё этот метод медленный и не красивый.
    # хотите использовать его - только на свой страх и риск.


    termux-notification \
        --icon    $icon \
        --title   "$title" \
        --content "$content1"$'\n'"$content2" \
        --button1 "$PREV_TEXT"  --button1-action 'cmus-remote --prev' \
        --button2 "$PAUS_TEXT"  --button2-action 'cmus-remote --pause' \
        --button3 "$NEXT_TEXT"  --button3-action 'cmus-remote --next' \
        --alert-once --ongoing --priority max --id $ID

    sleep $UPDATE_INTERVAL
done
