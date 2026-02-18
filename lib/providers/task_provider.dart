import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<TaskModel> _tasks = [];
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  List<TaskModel> get filteredTasks {
    if (_currentIndex == 1) return _tasks.where((t) => !t.isCompleted).toList();
    if (_currentIndex == 2) return _tasks.where((t) => t.isCompleted).toList();
    return _tasks;
  }

  void addTask(String title, CategoryData category, DateTime date) {
    _tasks.add(TaskModel(
      id: DateTime.now().toString(),
      title: title,
      category: category,
      date: date,
    ));
    notifyListeners();
  }

  void toggleStatus(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
    }
  }
}