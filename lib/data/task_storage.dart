import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class TaskStorage {
  static const String _key = 'tasks_list';

  Future<void> saveTasks(List<TaskModel> tasks) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final List<String> taskStrings = tasks.map((t) => jsonEncode(t.toMap())).toList();
    await pref.setStringList(_key, taskStrings);
  }

  Future<List<TaskModel>> loadTasks() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final List<String>? taskStrings = pref.getStringList(_key);
    if (taskStrings == null) return [];
    return taskStrings.map((item) => TaskModel.fromMap(jsonDecode(item))).toList();
  }
}