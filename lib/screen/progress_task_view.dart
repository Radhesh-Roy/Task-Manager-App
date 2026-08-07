import 'package:flutter/material.dart';

import '../data/model/task_model.dart';
import '../data/service/api_caller.dart';
import '../utils/urls.dart';
import '../widget/custom_task_card.dart';

class ProgressTaskView extends StatefulWidget {
  const ProgressTaskView({super.key});

  @override
  State<ProgressTaskView> createState() => _ProgressTaskViewState();
}
class _ProgressTaskViewState extends State<ProgressTaskView> {
  List<TaskModel>taskList = [];

  Future<void>getAllTask() async {
    final response = await ApiCaller().getRequest(URL: TMUrls.AllTask('Progress'));

    List<TaskModel> temList=[];

    if(response.isSuccess){
      for(Map<String,dynamic>jsonData in response.responseData['data']){
        temList.add(TaskModel.fromJson(jsonData));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.responseData['data'])));

    }

    taskList = temList;

    setState(() {

    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTask();
  }

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
                  child: taskList.isEmpty
                      ? const Center(
                    child: Text(
                      "No Task Found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ) : ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      return CustomTaskCard(
                        taskModel: taskList[index],
                        statusColor: Colors.purple,
                        refreshParent: () async {
                          await getAllTask();
                        },
                      );
                    },),
                )

              ],
            ),
          ),
        )
    );
  }
}
