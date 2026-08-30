import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/service/api_caller.dart';
import 'package:task_manager/utils/urls.dart';

class CompleteTaskProvider extends ChangeNotifier {
  List<TaskModel> taskList = [];

  bool isLoading = true;

  Future<void> getAllTask() async {
    isLoading = true;
    notifyListeners();

    final response = await ApiCaller().getRequest(
      URL: TMUrls.AllTask('Completed'),
    );

    if (response.isSuccess) {
      List<TaskModel> tempList = [];

      for (Map<String, dynamic> jsonData
      in response.responseData['data']) {
        tempList.add(
          TaskModel.fromJson(jsonData),
        );
      }

      taskList = tempList;
    }

    isLoading = false;
    notifyListeners();
  }
}