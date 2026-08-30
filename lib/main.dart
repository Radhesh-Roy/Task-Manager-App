import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/screen/new_task_view.dart';
import 'package:task_manager/screen/splash_screen.dart';

import 'controller/provider/auth_provider.dart';
import 'controller/provider/cancel_task_provider.dart';
import 'controller/provider/complete_task_provider.dart';
import 'controller/provider/new_task_provider.dart';
import 'controller/provider/profile_provider.dart';
import 'controller/provider/progress_task_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [

        // Authentication
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

        // New Task
        ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        ),

        // Progress Task
        ChangeNotifierProvider(
          create: (_) => ProgressTaskProvider(),
        ),

        // Cancelled Task
        ChangeNotifierProvider(
          create: (_) => CancelTaskProvider(),
        ),
        // Completed Task
        ChangeNotifierProvider(
          create: (_) => CompleteTaskProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Task Manager',

      initialRoute: "/splash",

      routes: {
        "/splash": (context) => const SplashScreenView(),

        "/newtask": (context) => const NewTaskView(),
      },
    );
  }
}