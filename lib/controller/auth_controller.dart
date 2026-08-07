
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/user_model.dart';

class AuthController {

  static String ? token;
  static UserModel ? userData;

  static Future saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('token', token);
    sharedPreferences.setString('user-data', jsonEncode(model.toString()));

    token = token;
    userData = model;
  }


  static Future getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String ? tkn = sharedPreferences.getString('token');

    if(tkn !=null){
      token = tkn;
    }

    String ? uData = sharedPreferences.getString('user-data');

    if(uData !=null){
      userData = UserModel.fromJson(jsonDecode(uData));
    }


  }

  static Future<bool> isUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String ? tkn = sharedPreferences.getString('token');

    if(tkn !=null){
      return true;
    }else{
      return false;
    }

    // return tkn != null;
  }

}