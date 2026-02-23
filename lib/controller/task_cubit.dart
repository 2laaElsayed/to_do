import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task_model.dart';
import '../data/task_storage.dart';

class TaskState {
  final List<TaskModel> tasks;
  final int currentIndex;
  final NavItemModel currentNav;

  TaskState({required this.tasks, required this.currentIndex, required this.currentNav});

  List<TaskModel> get filteredTasks {
    if (currentIndex == 1) return tasks.where((t) => !t.isChecked).toList();
    if (currentIndex == 2) return tasks.where((t) => t.isChecked).toList();
    return tasks;
  }
}

class TaskCubit extends Cubit<TaskState> {
  final TaskStorage _storage = TaskStorage();


  static const List<NavItemModel> _navConfigs = [
    NavItemModel(label: "Tasks", headerIcon: Icons.add_circle, themeColor: Colors.black),
    NavItemModel(label: "Pending", headerIcon: Icons.timer_outlined, themeColor: Colors.orange),
    NavItemModel(label: "Completed", headerIcon: Icons.check_circle, themeColor: Colors.teal),
  ];

  TaskCubit() : super(TaskState(tasks: [], currentIndex: 0, currentNav: _navConfigs[0])) {
    loadCachedTasks();
  }

  Future<void> loadCachedTasks() async {
    final cached = await _storage.loadTasks();
    emit(TaskState(tasks: cached, currentIndex: state.currentIndex, currentNav: state.currentNav));
  }

  void addTask(String title, TaskCategory category, DateTime selectedDate) async {
    if (title.trim().isEmpty) return;

    final newTask = TaskModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      time: TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute),
      date: selectedDate,
      categoryIndex: category.index,
      isChecked: false,
    );

    final newList = List<TaskModel>.from(state.tasks)..add(newTask);
    await _storage.saveTasks(newList);
    emit(TaskState(tasks: newList, currentIndex: state.currentIndex, currentNav: state.currentNav));
  }

  void toggleStatus(String id) async {
    final newList = state.tasks.map((task) {
      if (task.id == id) {

        return TaskModel(
            id: task.id,
            title: task.title,
            time: task.time,
            date: task.date,
            categoryIndex: task.categoryIndex,
            isChecked: !task.isChecked
        );
      }
      return task;
    }).toList();

    await _storage.saveTasks(newList);
    emit(TaskState(tasks: newList, currentIndex: state.currentIndex, currentNav: state.currentNav));
  }

  void deleteTask(String id) async {
    final newList = state.tasks.where((task) => task.id != id).toList();
    await _storage.saveTasks(newList);
    emit(TaskState(tasks: newList, currentIndex: state.currentIndex, currentNav: state.currentNav));
  }

  void setIndex(int index) {
    emit(TaskState(tasks: state.tasks, currentIndex: index, currentNav: _navConfigs[index]));
  }
}