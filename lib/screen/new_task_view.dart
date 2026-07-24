import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_model.dart';

import '../widget/custom_task_card.dart';

class NewTaskView extends StatefulWidget {
  const NewTaskView({super.key});

  @override
  State<NewTaskView> createState() => _NewTaskViewState();
}

class _NewTaskViewState extends State<NewTaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        tooltip: "Add Task",
        shape: CircleBorder(),
        onPressed: (){}, child: Text("+", style: TextStyle(color: Colors.white, fontSize: 20),),),
      body:SafeArea(
        child: Padding(padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    width: 115,
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),

                    child: Column(
                      children: [
                        Text("09", style: TextStyle(fontWeight: FontWeight.w600),),
                        Text("Cancelled", style: TextStyle(fontWeight: FontWeight.w400),),
                      ],
                    ),
                  );
              },
                    separatorBuilder:(context, index) {
                      return SizedBox(width: 5,);
                    },),
            ),
            SizedBox(height: 15,),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                return CustomTaskCard(taskModel: TaskModel(
                  title: "This is titleeeee",
                  description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London,",
                  status: "New",
                  createdDate: "24/07/2026",
                ),
                statusColor: Colors.blue,);
              },),
            )

          ],
        ),
        ),
      )
    );
  }
}
