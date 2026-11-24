// Disable the Tasker Hide Recents profile before running this action.
am = context.getSystemService(android.content.Context.ACTIVITY_SERVICE);
tasks = am.getAppTasks();
for (int i = 0; i < tasks.size(); i++) {
    tasks.get(i).setExcludeFromRecents(false);
}
return tasks.size();
