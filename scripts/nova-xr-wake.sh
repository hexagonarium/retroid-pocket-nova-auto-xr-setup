#!/system/bin/sh
DP=/sys/class/drm/card0-DP-1/status
connected() {
    IFS= read -r dp_state < "$DP" && [ "$dp_state" = connected ]
}
connected || exit 0
sleep 1
connected || exit 0
settings put system close_screen_when_output_video 0
sleep 0.25
settings put system close_screen_when_output_video 1
settings put system show_touches 1
echo "$(date '+%F %T') wake event: reapplied Retroid screen-off preference" >> /data/local/tmp/nova-xr-wake.log
