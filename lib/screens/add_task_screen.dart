import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final controller = TextEditingController();
  CategoryData selectedCategory = appCategories[0];
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontSize: 16))),
            ),
            const SizedBox(height: 20),
            const Text("Add a task", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),

            TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "Name your task", border: UnderlineInputBorder()),
            ),
            const SizedBox(height: 30),

            DropdownButton<CategoryData>(
              value: selectedCategory,
              isExpanded: true,
              underline: Container(height: 1, color: Colors.grey[300]),
              items: appCategories.map((cat) => DropdownMenuItem(
                value: cat,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: cat.color.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
                      child: Icon(cat.icon, color: cat.color, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Text(cat.name, style: TextStyle(color: cat.color)),
                  ],
                ),
              )).toList(),
              onChanged: (val) => setState(() => selectedCategory = val!),
            ),

            const SizedBox(height: 30),

            InkWell(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (picked != null) setState(() => selectedDate = picked);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${selectedDate.month}/${selectedDate.day}/${selectedDate.year.toString().substring(2)}", style: const TextStyle(fontSize: 16)),
                    const Icon(Icons.calendar_month_outlined, color: Colors.grey),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 100),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  context.read<TaskProvider>().addTask(controller.text, selectedCategory, selectedDate);
                  Navigator.pop(context);
                }
              },
              child: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }
}