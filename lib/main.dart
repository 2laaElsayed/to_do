import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controller/task_cubit.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => TaskCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
}