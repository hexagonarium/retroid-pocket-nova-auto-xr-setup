# Optional: hide Tasker from Recents

Tested logic on Tasker **6.7.9**, Nova Android 13. Root is not needed for this add-on; the XR helpers still require root.

1. Download [Tasker Hide Recents.prj.xml](Tasker%20Hide%20Recents.prj.xml?raw=true) to the Nova.
2. Long-press Tasker’s bottom Home/project tab → **Import Project**.
3. Grant **Usage access** when Tasker requests it. This lets the App Changed event run.
4. Enable **Tasker Hide Recents**, apply, then leave Tasker.

The event runs on app changes and calls Android’s `setExcludeFromRecents(true)` only on Tasker’s own tasks. It keeps the monitoring service running. It does not stop or hide other apps.

**Undo:** disable the profile first, then run **Show Tasker Recents** from the Tasks tab. Keep that profile disabled or it will hide the card again.

**Manual setup:** Event → App → App Changed, Package blank; task → Code → Java Code; paste [HideTaskerRecents.java](HideTaskerRecents.java). The companion Show file reverses it.

Keep Tasker excluded from battery optimization. Hiding does not bypass Android Settings → Force stop; reopen Tasker afterward. If an equivalent profile already exists, don’t import a duplicate.

[Android API](https://developer.android.com/reference/android/app/ActivityManager.AppTask#setExcludeFromRecents(boolean)) · [Tasker Java Code](https://tasker.joaoapps.com/userguide/en/help/ah_java_code.html)
