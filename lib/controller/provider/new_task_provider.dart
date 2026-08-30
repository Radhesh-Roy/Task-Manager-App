import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/model/task-model_count.dart';
import 'package:task_manager/data/service/api_caller.dart';
import 'package:task_manager/utils/urls.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskStatusCountModel> taskCountList = [];
  List<TaskModel> taskList = [];

  bool isLoading = true;

  Future<void> loadData() async {
    isLoading = true;
    notifyListeners();

    await Future.wait([getAllTaskCount(), getAllTask()]);

    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllTaskCount() async {
    final response = await ApiCaller().getRequest(URL: TMUrls.taskCount);

    if (response.isSuccess) {
      List<TaskStatusCountModel> tempList = [];

      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        tempList.add(TaskStatusCountModel.fromJson(jsonData));
      }

      taskCountList = tempList;

      notifyListeners();
    }
  }

  Future<void> getAllTask() async {
    final response = await ApiCaller().getRequest(URL: TMUrls.AllTask('New'));

    if (response.isSuccess) {
      List<TaskModel> tempList = [];

      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        tempList.add(TaskModel.fromJson(jsonData));
      }

      taskList = tempList;

      notifyListeners();
    }
  }
}
