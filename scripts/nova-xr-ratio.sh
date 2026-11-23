#!/system/bin/sh
umask 077
SELF=/data/local/tmp/nova-xr-ratio.sh
DP=/sys/class/drm/card0-DP-1/status
LOG=/data/local/tmp/nova-xr-ratio.log

connected() {
    [ "$(cat "$DP" 2>/dev/null)" = connected ]
}

wide() {
    settings put system show_touches 1
    if ! wm size | grep -q 'Override size: 1080x1920'; then
        wm size 1080x1920
        echo "$(date '+%F %T') physical DP connected: applied 16:9" >> "$LOG"
    fi
}

native() {
    wm size reset
    settings put system show_touches 0
    echo "$(date '+%F %T') physical DP disconnected: restored native 4:3" >> "$LOG"
}

if [ "$1" = watch ]; then
    exec 9>/data/local/tmp/nova-xr-ratio.lock
    flock -n 9 9>&9 || exit 0
    connected || exit 0
    echo "$(date '+%F %T') unplug watcher started, pid $$" >> "$LOG"
    misses=0
    while :; do
        if connected; then
            misses=0
        else
            misses=$((misses + 1))
            if [ "$misses" -ge 2 ]; then
                native
                exit 0
            fi
        fi
        sleep 1
    done
fi

if connected; then
    wide
    /system/bin/toybox nohup /system/bin/sh "$SELF" watch </dev/null >/dev/null 2>&1 &
else
    native
fi
