import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/screen/add_new_task.dart';
import 'package:task_manager/widget/custom_task_card.dart';

import '../controller/provider/new_task_provider.dart';

class NewTaskView extends StatefulWidget {
  const NewTaskView({super.key});

  @override
  State<NewTaskView> createState() => _NewTaskViewState();
}

class _NewTaskViewState extends State<NewTaskView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {context.read<TaskProvider>().loadData();});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape:  CircleBorder(),

        child:  Icon(Icons.add, color: Colors.white),

        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddNewTask()),
          );

          await context.read<TaskProvider>().loadData();
        },
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),

          child: Consumer<TaskProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  SizedBox(
                    height: 80,

                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,

                      itemCount: provider.taskCountList.length,

                      separatorBuilder: (_, __) => SizedBox(width: 10),

                      itemBuilder: (context, index) {
                        return Container(
                          width: 120,

                          padding: const EdgeInsets.all(10),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(10),

                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 4),
                            ],
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Text(
                                provider.taskCountList[index].sId ?? "",

                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 5),

                              Text(
                                "${provider.taskCountList[index].sum ?? 0}",

                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 15),

                  Expanded(
                    child: provider.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : provider.taskList.isEmpty
                        ? Center(child: Text("No Task Found"))
                        : ListView.builder(
                            itemCount: provider.taskList.length,

                            itemBuilder: (context, index) {
                              return CustomTaskCard(
                                taskModel: provider.taskList[index],

                                statusColor: Colors.blue,

                                refreshParent: () async {
                                  await context.read<TaskProvider>().loadData();
                                },
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
