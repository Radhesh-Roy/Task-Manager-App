import 'package:flutter/material.dart';

import '../data/model/task_model.dart';
import '../widget/custom_task_card.dart';

class CompleteTaskView extends StatefulWidget {
  const CompleteTaskView({super.key});

  @override
  State<CompleteTaskView> createState() => _CompleteTaskViewState();
}

class _CompleteTaskViewState extends State<CompleteTaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body:SafeArea(
          child: Padding(padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return CustomTaskCard(taskModel: TaskModel(
                        title: "This is title",
                        description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London,",
                        status: "Completed",
                        createdDate: "24/07/2026",
                      ),
                        statusColor: Colors.greenAccent,);
                    },),
                )

              ],
            ),
          ),
        )
    );
  }
}
