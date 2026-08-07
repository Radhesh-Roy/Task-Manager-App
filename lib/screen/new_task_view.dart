import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/service/api_caller.dart';
import 'package:task_manager/screen/add_new_task.dart';
import 'package:task_manager/utils/urls.dart';
import 'package:task_manager/widget/custom_task_card.dart';

import '../data/model/task-model_count.dart';

class NewTaskView extends StatefulWidget {
  const NewTaskView({super.key});

  @override
  State<NewTaskView> createState() => _NewTaskViewState();
}

class _NewTaskViewState extends State<NewTaskView> {
  List<TaskStatusCountModel> taskCountList = [];
  List<TaskModel> taskList = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    await Future.wait([
      getAllTaskCount(),
      getAllTask(),
    ]);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getAllTaskCount() async {
    final response =
    await ApiCaller().getRequest(URL: TMUrls.taskCount);

    if (response.isSuccess) {
      List<TaskStatusCountModel> tempList = [];

      for (Map<String, dynamic> jsonData
      in response.responseData['data']) {
        tempList.add(TaskStatusCountModel.fromJson(jsonData));
      }

      setState(() {
        taskCountList = tempList;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.responseData?['message'] ?? "Something went wrong",
          ),
        ),
      );
    }
  }

  Future<void> getAllTask() async {
    final response =
    await ApiCaller().getRequest(URL: TMUrls.AllTask('New'));

    if (response.isSuccess) {
      List<TaskModel> tempList = [];

      for (Map<String, dynamic> jsonData
      in response.responseData['data']) {
        tempList.add(TaskModel.fromJson(jsonData));
      }
setState(() {
  taskList = tempList;
});

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.responseData['message'] ?? "Something went wrong",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddNewTask(),
            ),
          );

          loadData();
        },
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: taskCountList.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 120,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(10),
                        boxShadow:  [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            taskCountList[index].sId ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                           SizedBox(height: 5),
                          Text(
                            "${taskCountList[index].sum ?? 0}",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

               SizedBox(height: 15),

              Expanded(
                child: isLoading
                    ?  Center(
                  child: CircularProgressIndicator(),
                )
                    : taskList.isEmpty
                    ? Center(
                  child: Text("No Task Found"),
                )
                    : ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    return CustomTaskCard(
                      taskModel: taskList[index],
                      statusColor: Colors.blue, refreshParent: () async {
                      await loadData();
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