import 'package:flutter/material.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/data/model/api_response.dart';
import 'package:task_manager/data/model/user_model.dart';
import 'package:task_manager/data/service/api_caller.dart';
import 'package:task_manager/utils/urls.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<bool> register({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller().postRequest(
      URL: TMUrls.SignupURL,
      body: {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "password": password,
      },
    );

    isLoading = false;
    notifyListeners();

    return response.isSuccess;
  }

  Future<bool> login({required String email, required String password}) async {
    isLoading = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller().postRequest(
      URL: TMUrls.LoginURL,
      body: {"email": email, "password": password},
    );

    if (response.isSuccess) {
      UserModel model = UserModel.fromJson(response.responseData['data']);

      String token = response.responseData['token'];

      AuthController.saveUserData(model, token);
    }

    isLoading = false;
    notifyListeners();

    return response.isSuccess;
  }
}
