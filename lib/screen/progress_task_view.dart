import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/provider/progress_task_provider.dart';
import '../widget/custom_task_card.dart';

class ProgressTaskView extends StatefulWidget {
  const ProgressTaskView({super.key});

  @override
  State<ProgressTaskView> createState() => _ProgressTaskViewState();
}

class _ProgressTaskViewState extends State<ProgressTaskView> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProgressTaskProvider>().getAllTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),

          child: Consumer<ProgressTaskProvider>(
            builder: (context, provider, child) {
              return Expanded(
                child: provider.isLoading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : provider.taskList.isEmpty
                    ? const Center(
                  child: Text(
                    "No Task Found",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: provider.taskList.length,

                  itemBuilder: (context, index) {
                    return CustomTaskCard(
                      taskModel: provider.taskList[index],

                      statusColor: Colors.purple,

                      refreshParent: () async {
                        await context
                            .read<ProgressTaskProvider>()
                            .getAllTask();
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}