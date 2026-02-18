import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/task_cubit.dart';
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
              _buildHeader(),
              const SizedBox(height: 25),
              Expanded(
                child: BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.filteredTasks.length,
                      itemBuilder: (context, index) => TaskItem(task: state.filteredTasks[index]),
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

  Widget _buildHeader() {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        String title = state.currentIndex == 0 ? "Tasks" : (state.currentIndex == 1 ? "Pending" : "Completed");
        IconData icon = state.currentIndex == 0 ? Icons.add_circle : (state.currentIndex == 1 ? Icons.timer_outlined : Icons.check_circle);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            IconButton(
              icon: Icon(icon, size: 40, color: state.currentIndex == 1 ? Colors.orange : (state.currentIndex == 2 ? Colors.teal : Colors.black)),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTaskScreen())),
            ),
          ],
        );
      },
    );
  }
}

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navBtn(context, "All", 0, state.currentIndex == 0),
              _navBtn(context, "Pending", 1, state.currentIndex == 1),
              _navBtn(context, "Completed", 2, state.currentIndex == 2),
            ],
          ),
        );
      },
    );
  }

  Widget _navBtn(BuildContext context, String label, int index, bool active) {
    return GestureDetector(
      onTap: () => context.read<TaskCubit>().setIndex(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(color: active ? Colors.black : Colors.transparent, borderRadius: BorderRadius.circular(25)),
        child: Text(label, style: TextStyle(color: active ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
      ),
    );
  }
}