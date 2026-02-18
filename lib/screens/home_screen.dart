import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_item.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<TaskProvider>(
                builder: (context, provider, _) {
                  String title = "Tasks";
                  IconData topIcon = Icons.add_circle;
                  Color iconColor = Colors.black;

                  if (provider.currentIndex == 1) {
                    title = "Pending";
                    topIcon = Icons.timer_outlined;
                    iconColor = Colors.orange;
                  } else if (provider.currentIndex == 2) {
                    title = "Completed";
                    topIcon = Icons.check_circle;
                    iconColor = Colors.teal;
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      provider.currentIndex == 0
                          ? IconButton(
                        icon: Icon(topIcon, size: 40, color: iconColor),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTaskScreen())),
                      )
                          : Icon(topIcon, size: 35, color: iconColor),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Consumer<TaskProvider>(
                  builder: (context, provider, _) {
                    final tasks = provider.filteredTasks;
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) => TaskItem(task: tasks[index]),
                    );
                  },
                ),
              ),

              const CustomNavBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navBtn(context, "All", 0, provider.currentIndex == 0),
          _navBtn(context, "Pending", 1, provider.currentIndex == 1),
          _navBtn(context, "Completed", 2, provider.currentIndex == 2),
        ],
      ),
    );
  }

  Widget _navBtn(BuildContext context, String label, int index, bool active) {
    return GestureDetector(
      onTap: () => Provider.of<TaskProvider>(context, listen: false).setIndex(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(label, style: TextStyle(color: active ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
      ),
    );
  }
}