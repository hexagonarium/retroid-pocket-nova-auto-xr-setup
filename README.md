# Retroid Pocket Nova Auto XR setup

Automatic XR-glasses display management for a **rooted Retroid Pocket Nova**, using Tasker.

Plug in the glasses, get a 16:9 picture, and use the Nova's touchscreen while its own screen is blanked. Unplug and return to native 4:3. The setup also reapplies Retroid's screen-off setting after sleep and wake.

## Improved behavior

| When | What happens |
| --- | --- |
| Plug in the glasses | Apply landscape 16:9 and enable touch markers. Retroid's video-output setting blanks the built-in screen. |
| Touch the blanked screen | Finger markers remain visible in the glasses so you can see where you are touching. |
| Sleep and wake with glasses connected | After roughly 1–2 seconds, reapply Retroid's screen-off setting while keeping touch accurate. |
| Unplug the glasses | Restore native 4:3 after about 1–2 seconds and turn touch markers off. |
| Wake without glasses | The added wake task exits without changing the screen-off setting. |

## Download and install

**[Download the complete setup ZIP](retroid-pocket-nova-auto-xr-setup-v1.0.0.zip?raw=true)**

1. Extract the ZIP on your PC and open a terminal inside its folder.
2. Enable USB debugging on the Nova and connect it to the PC. Keep the glasses unplugged during installation.
3. Copy the helpers and Tasker project:

```sh
adb devices
adb push scripts/nova-xr-ratio.sh /data/local/tmp/nova-xr-ratio.sh
adb push scripts/nova-xr-wake.sh /data/local/tmp/nova-xr-wake.sh
adb shell su -c "chmod 700 /data/local/tmp/nova-xr-ratio.sh /data/local/tmp/nova-xr-wake.sh"
adb push "Retroid Pocket Nova Auto XR setup.prj.xml" /sdcard/Download/
```

4. Enable Retroid's option to turn off the built-in screen when outputting video. Menu wording can vary by firmware.
5. In Tasker, long-press a bottom project tab or the Home icon, choose **Import Project**, and select the `.prj.xml` file from Downloads. Grant Tasker root access and enable the three profiles.
6. Save/apply, connect the glasses, and test plug/unplug and power-button sleep/wake.

**[Full Tasker tutorial, manual setup, troubleshooting, and removal](TASKER%20SETUP.txt)**

Import the project rather than restoring it as a full Tasker backup. Importing the XML does not install the scripts: both copy steps are required. Disable older HDMI/resolution automation first to avoid conflicting profiles.

## Why check the physical connection?

During testing, the Nova reported HDMI connected and then HDMI disconnected while the physical DisplayPort connection stayed present. An unconditional Tasker reset could therefore undo 16:9 immediately.

Both ratio tasks call a helper that checks `/sys/class/drm/card0-DP-1/status`. A single watcher runs only while DP is connected. It checks once per second; two disconnected readings restore native size and stop the watcher. A false HDMI-disconnect event therefore does not immediately undo the XR layout.

The wake task is a separate, one-shot action. It checks DP, waits one second, rechecks, then toggles Retroid's `close_screen_when_output_video` setting off and back on with a 0.25-second gap. This repeats Retroid's own working action after wake. It does not change compositor power, brightness, or touch coordinates.

## Tasker profiles

| Profile | Trigger | Task |
| --- | --- | --- |
| Switch 16:9 | HDMI Plugged | Switch Ratio |
| Revert 4:3 | HDMI Plugged, inverted | Wait two seconds, then Revert Ratio |
| XR Screen Wake | Display On | XR Wake Reblank |

Every Run Shell action uses root. The helpers decide what to do from the actual DP connection, rather than trusting the HDMI event alone.

## Tested setup and limits

- Retroid Pocket Nova with root, Android 13.
- Firmware `RPN_V1.0.0.436_20260722_083524_user`.
- Tasker 6.7.9.
- **RayNeo Air 4 Pro** glasses.
- Used with DroidDeck 0.7.1. This project does not modify DroidDeck or require it to be running.

Plug/unplug, touch markers, and the delayed wake action were confirmed on this setup. The shareable Tasker project was assembled from that working configuration, with redundant shell calls removed and its references checked.

**This is a root-only, Nova-specific release. Other devices, firmware builds, and a non-root/Shizuku version have not been verified.** Another physical DP display may also trigger the setup. Restoring native size removes an existing custom resolution override; the scripts do not preserve a previous custom override.

Android's separate request to let DroidDeck access the glasses' USB electronics may still appear. This project does not suppress or automatically approve it.

## Disable or remove

Disable the three imported profiles, unplug the glasses, and wait at least three seconds for the watcher to stop. Delete the imported project if desired. To restore defaults manually from an authorized ADB connection:

```sh
adb shell su -c "wm size reset"
adb shell su -c "settings put system show_touches 0"
```

The wake task leaves Retroid's video-output screen-off option enabled. You can turn it off in Retroid settings. The full tutorial lists the helper files and log locations for cleanup.

## Feedback

If you try this, report your Nova firmware, Tasker version, glasses model, and which behavior worked or failed. Use at your own risk; keep a backup of your Tasker configuration before importing.
