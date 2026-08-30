import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/provider/complete_task_provider.dart';
import '../widget/custom_task_card.dart';

class CompleteTaskView extends StatefulWidget {
  const CompleteTaskView({super.key});

  @override
  State<CompleteTaskView> createState() => _CompleteTaskViewState();
}

class _CompleteTaskViewState extends State<CompleteTaskView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {context.read<CompleteTaskProvider>().getAllTask();});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),

          child: Column(
            children: [
              Expanded(
                child: Consumer<CompleteTaskProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (provider.taskList.isEmpty) {
                      return Center(
                        child: Text(
                          "No Task Found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: provider.taskList.length,

                      itemBuilder: (context, index) {
                        return CustomTaskCard(
                          taskModel: provider.taskList[index],

                          statusColor: Colors.greenAccent,

                          refreshParent: () async {
                            await context
                                .read<CompleteTaskProvider>()
                                .getAllTask();
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
