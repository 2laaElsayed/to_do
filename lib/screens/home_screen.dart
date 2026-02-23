import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../controller/task_cubit.dart';
import '../widgets/task_item.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Text(
                DateFormat('EEEE, d MMMM').format(DateTime.now()),
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    final tasks = state.filteredTasks;
                    if (tasks.isEmpty) {
                      return const Center(child: Text("No tasks here"));
                    }
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

  Widget _buildHeader(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(state.currentNav.label,
                style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
            IconButton(
              icon: Icon(state.currentNav.headerIcon, size: 40, color: state.currentNav.themeColor),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddTaskScreen())
              ),
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navBtn(context, "All", 0, state.currentIndex == 0),
              _navBtn(context, "Pending", 1, state.currentIndex == 1),
              _navBtn(context, "Done", 2, state.currentIndex == 2),
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
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: BoxDecoration(
            color: active ? Colors.black : Colors.transparent,
            borderRadius: BorderRadius.circular(25)
        ),
        child: Text(label,
            style: TextStyle(
                color: active ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold
            )),
      ),
    );
  }
}