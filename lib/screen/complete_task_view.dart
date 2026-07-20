import 'package:flutter/material.dart';

class CompleteTaskView extends StatefulWidget {
  const CompleteTaskView({super.key});

  @override
  State<CompleteTaskView> createState() => _CompleteTaskViewState();
}

class _CompleteTaskViewState extends State<CompleteTaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("complete task")),
    );
  }
}
