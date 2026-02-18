import 'package:flutter/material.dart';

class CategoryData {
  final String name;
  final IconData icon;
  final Color color;
  CategoryData({required this.name, required this.icon, required this.color});
}

final List<CategoryData> appCategories = [
  CategoryData(name: "Personal", icon: Icons.person_outline, color: Colors.teal),
  CategoryData(name: "Work", icon: Icons.work_outline, color: Colors.blue),
  CategoryData(name: "Health", icon: Icons.medical_services_outlined, color: Colors.red),
  CategoryData(name: "Family", icon: Icons.home_outlined, color: Colors.purple),
  CategoryData(name: "Learning", icon: Icons.school_outlined, color: Colors.orange),
];

class TaskModel {
  final String id;
  final String title;
  final CategoryData category;
  final DateTime date;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    this.isCompleted = false,
  });
}