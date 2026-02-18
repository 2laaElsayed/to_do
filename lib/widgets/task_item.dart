import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: ListTile(
        leading: Consumer<TaskProvider>(
          builder: (context, provider, _) => Checkbox(
            value: task.isCompleted,
            activeColor: const Color(0xFF008080),
            onChanged: (val) => provider.toggleStatus(task.id),
          ),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: task.isCompleted ? Colors.grey : Colors.black87,
          ),
        ),
        subtitle: Text(
          "${task.date.day}/${task.date.month}/${task.date.year}",
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}