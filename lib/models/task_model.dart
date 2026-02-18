import 'package:flutter/material.dart';

class CategoryData {
  final String name;
  final IconData icon;
  final Color color;

  CategoryData({required this.name, required this.icon, required this.color});
}

class TaskModel {
  final String id;
  String title;
  CategoryData category;
  DateTime date;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    this.isCompleted = false,
  });
}

final List<CategoryData> appCategories = [
  CategoryData(name: "Personal", icon: Icons.person_outline, color: Colors.teal),
  CategoryData(name: "Work", icon: Icons.work_outline, color: Colors.blue),
  CategoryData(name: "Health", icon: Icons.favorite_outline, color: Colors.red),
  CategoryData(name: "Family", icon: Icons.home_outlined, color: Colors.purple),
  CategoryData(name: "Learning", icon: Icons.school_outlined, color: Colors.orange),
];