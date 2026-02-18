import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task_model.dart';

class TaskState {
  final List<TaskModel> tasks;
  final int currentIndex;

  TaskState({required this.tasks, required this.currentIndex});

  List<TaskModel> get filteredTasks {
    if (currentIndex == 1) return tasks.where((t) => !t.isCompleted).toList();
    if (currentIndex == 2) return tasks.where((t) => t.isCompleted).toList();
    return tasks;
  }
}

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskState(tasks: [], currentIndex: 0));

  void setIndex(int index) {
    emit(TaskState(tasks: state.tasks, currentIndex: index));
  }

  void addTask(String title, CategoryData category, DateTime date) {
    final newList = List<TaskModel>.from(state.tasks)
      ..add(TaskModel(id: DateTime.now().toString(), title: title, category: category, date: date));
    emit(TaskState(tasks: newList, currentIndex: state.currentIndex));
  }

  void toggleStatus(String id) {
    final newList = state.tasks.map((task) {
      if (task.id == id) {
        return TaskModel(
          id: task.id, title: task.title, category: task.category,
          date: task.date, isCompleted: !task.isCompleted,
        );
      }
      return task;
    }).toList();
    emit(TaskState(tasks: newList, currentIndex: state.currentIndex));
  }
}