import 'package:flutter/material.dart';

enum TaskCategory {
  personal("Personal", Icons.person_outline, Colors.teal),
  work("Work", Icons.work_outline, Colors.blue),
  health("Health", Icons.medical_services_outlined, Colors.red),
  family("Family", Icons.home_outlined, Colors.purple),
  learning("Learning", Icons.school_outlined, Colors.orange);

  final String name;
  final IconData icon;
  final Color color;
  const TaskCategory(this.name, this.icon, this.color);
}

class NavItemModel {
  final String label;
  final IconData headerIcon;
  final Color themeColor;

  const NavItemModel({
    required this.label,
    required this.headerIcon,
    required this.themeColor
  });
}
class TaskModel {
  final String id;
  final String title;
  final TimeOfDay time;
  final DateTime date;
  final int categoryIndex;
  bool isChecked;

  TaskModel({
    required this.id,
    required this.title,
    required this.time,
    required this.date,
    required this.categoryIndex,
    this.isChecked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'hour': time.hour,
      'minute': time.minute,
      'date': date.toIso8601String(),
      'categoryIndex': categoryIndex,
      'isChecked': isChecked,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      time: TimeOfDay(hour: map['hour'], minute: map['minute']),
      date: DateTime.parse(map['date']),
      categoryIndex: map['categoryIndex'] ?? 0,
      isChecked: map['isChecked'],
    );
  }
}