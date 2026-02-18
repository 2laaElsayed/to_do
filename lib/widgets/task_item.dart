import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task_model.dart';
import '../controller/task_cubit.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: ListTile(
        leading: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return Checkbox(
              value: task.isCompleted,
              activeColor: const Color(0xFF008080),
              onChanged: (_) => context.read<TaskCubit>().toggleStatus(task.id),
            );
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: task.isCompleted ? Colors.grey : Colors.black87,
            decoration: TextDecoration.none,
          ),
        ),
        subtitle: Text("${task.date.month}/${task.date.day}/${task.date.year}"),
      ),
    );
  }
}