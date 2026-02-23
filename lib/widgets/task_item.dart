import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task_model.dart';
import '../controller/task_cubit.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      onDismissed: (_) => context.read<TaskCubit>().deleteTask(task.id),
      background: Container(
        color: Colors.red.withOpacity(0.1),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.red),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Checkbox(
            value: task.isChecked,
            activeColor: const Color(0xFF008080),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onChanged: (_) => context.read<TaskCubit>().toggleStatus(task.id),
          ),
          title: Text(
            task.title,
            style: TextStyle(
              color: task.isChecked ? Colors.grey : Colors.black87,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            formatTime(task.time),
            style: TextStyle(color: task.isChecked ? Colors.grey : Colors.blueGrey),
          ),
        ),
      ),
    );
  }
}