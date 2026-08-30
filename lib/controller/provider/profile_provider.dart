import 'package:flutter/material.dart';
import 'package:task_manager/data/model/user_model.dart';
import 'package:task_manager/data/service/api_caller.dart';
import 'package:task_manager/utils/urls.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? userModel;

  bool isLoading = false;
  bool isUpdating = false;

  // =========================
  // GET PROFILE
  // =========================

  Future<void> getUser() async {
    isLoading = true;
    notifyListeners();

    final response = await ApiCaller().getRequest(
      URL: TMUrls.profileDetails,
    );

    if (response.isSuccess) {
      List<UserModel> tempList = [];

      for (Map<String, dynamic> jsonData
      in response.responseData['data']) {
        tempList.add(
          UserModel.fromJson(jsonData),
        );
      }

      if (tempList.isNotEmpty) {
        userModel = tempList.first;
      }
    }

    isLoading = false;
    notifyListeners();
  }

  // =========================
  // UPDATE PROFILE
  // =========================

  Future<bool> updateProfile({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  }) async {
    isUpdating = true;
    notifyListeners();

    final response = await ApiCaller().postRequest(
      URL: TMUrls.profileUpdate,
      body: {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "password": password,
      },
    );

    if (response.isSuccess) {
      // =========================
      // UPDATE PROVIDER DATA
      // =========================

      if (userModel != null) {
        userModel!.email = email;
        userModel!.firstName = firstName;
        userModel!.lastName = lastName;
        userModel!.mobile = mobile;
      }

      isUpdating = false;
      notifyListeners();

      return true;
    }

    isUpdating = false;
    notifyListeners();

    return false;
  }
}