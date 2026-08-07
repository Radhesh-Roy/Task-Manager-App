import 'package:flutter/material.dart';

import '../data/model/task_model.dart';
import '../data/service/api_caller.dart';
import '../utils/urls.dart';
import '../widget/custom_task_card.dart';

class CancelTaskView extends StatefulWidget {
  const CancelTaskView({super.key});

  @override
  State<CancelTaskView> createState() => _CancelTaskViewState();
}

class _CancelTaskViewState extends State<CancelTaskView> {

  List<TaskModel>taskList = [];

  Future<void>getAllTask() async {
    final response = await ApiCaller().getRequest(URL: TMUrls.AllTask('Cancelled'));

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
                  child: ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      return CustomTaskCard(taskModel: TaskModel(
                        title: "${taskList[index].title}",
                        description: "${taskList[index].description}",
                        status: "${taskList[index].status}",
                        createdDate: "${taskList[index].createdDate}",
                      ),
                        statusColor: Colors.redAccent, refreshParent: () { getAllTask(); },);
                    },),
                )

              ],
            ),
          ),
        )
    );
  }
}
