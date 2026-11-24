# Retroid Pocket Nova Auto XR setup

Root + Tasker setup, tested on Nova / Android 13 / Tasker 6.7.9 / RayNeo Air 4 Pro.

- Plug in: **16:9**, Nova screen blanked, touch markers visible in the glasses.
- Sleep/wake: reblank after about a second, keeping touch accurate.
- Unplug: native **4:3**, touch markers off.
- Ignores false HDMI disconnects while DisplayPort remains connected.

## Install

[Download setup ZIP](retroid-pocket-nova-auto-xr-setup-v1.1.0.zip?raw=true) on the Nova and extract it.

1. With glasses unplugged, long-press Tasker’s bottom Home/project tab → **Import Project** → select `Retroid Pocket Nova Auto XR setup.prj.xml`.
2. Open **Tasks → Install XR Helpers → Run** once. Grant root. This installs both scripts; **no PC needed**.
3. Enable Retroid’s **screen off when outputting video** option, enable the three XR profiles, and apply.

Import once; disable older HDMI automation. [Manual ADB install / removal](TASKER%20SETUP.txt).

## Keep Tasker running

Set Android **Apps → Tasker → Battery → Unrestricted** (or exclude it from battery optimization). Keep Tasker’s foreground monitor enabled.

On this Nova firmware, swiping Tasker away or using Recents cleanup can force-stop it. Keep its card locked using the padlock above it, or use the optional hiding project below. If stopped, reopen Tasker; extra battery permissions cannot override an explicit force-stop.

## Optional: hide Tasker from Recents

[Import the optional add-on](optional/Tasker%20Hide%20Recents.prj.xml?raw=true), grant **Usage access** when prompted, and enable **Tasker Hide Recents**. It hides Tasker’s own card on app changes while monitoring continues. Verified through **Clear all**.

To undo: disable that profile, then run **Show Tasker Recents**. [Short instructions](optional/README.md).

## Import / export

Use **Import Project**, not full **Data → Restore**. To share your changes: long-press a project tab → **Export → XML to Storage**. Back up all Tasker data separately before editing.

[Checks and removal](TASKER%20SETUP.txt) · [JamesDSP audio presets](https://github.com/hexagonarium/Retroid-Nova-JamesDSP-setup)

Nova/root only; other firmware unverified. DroidDeck’s separate USB-permission prompt may still appear. Use at your own risk.
