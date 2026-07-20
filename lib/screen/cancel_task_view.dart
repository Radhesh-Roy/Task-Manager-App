import 'package:flutter/material.dart';

class CancelTaskView extends StatefulWidget {
  const CancelTaskView({super.key});

  @override
  State<CancelTaskView> createState() => _CancelTaskViewState();
}

class _CancelTaskViewState extends State<CancelTaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("Cancel task")),
    );
  }
}
