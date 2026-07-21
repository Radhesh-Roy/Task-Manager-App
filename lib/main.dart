import 'package:flutter/material.dart';
import 'package:task_manager/screen/new_task_view.dart';
import 'package:task_manager/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      initialRoute:"/newtask" ,
      routes: {
        "/splash": (context)=> SplashScreenView(),
        "/newtask": (context)=> NewTaskView()
      },
    );
  }
}
