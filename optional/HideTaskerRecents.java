// Paste into a Tasker Java Code action (not a standalone Java class).
am = context.getSystemService(android.content.Context.ACTIVITY_SERVICE);
tasks = am.getAppTasks();
for (int i = 0; i < tasks.size(); i++) {
    tasks.get(i).setExcludeFromRecents(true);
}
return tasks.size();
