import 'dart:convert';

import 'package:task_manager/data/model/api_response.dart';
import 'package:http/http.dart';

import '../../controller/auth_controller.dart';

class ApiCaller {

  Future<ApiResponse>getRequest({required String URL}) async {
    try{
      Uri url=Uri.parse(URL);
    Response response = await get(url, headers: {
        "token": AuthController.token ?? ""
      });

      if(response.statusCode==200){
        return ApiResponse(responseCode: response.statusCode, responseData: jsonDecode(response.body), isSuccess:true);
      }
      else{
        return ApiResponse(responseCode: response.statusCode, responseData: jsonDecode(response.body), isSuccess: false, errorMessage: jsonDecode(response.body));
      }
    }catch(e){
      return ApiResponse(responseCode: -1, responseData: null, isSuccess: false, errorMessage:e.toString());

    }

  }

  Future<ApiResponse>postRequest({required String URL, Map<String, dynamic>?body}) async {

    try{
      Uri url=Uri.parse(URL);
    Response response = await post(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "token": AuthController.token ?? ""
      },
      body: body!=null?jsonEncode(body):null
      );

      if(response.statusCode==200|| response.statusCode==201){
        return ApiResponse(responseCode: response.statusCode, responseData: jsonDecode(response.body), isSuccess:true);
      }
      else{
        return ApiResponse(responseCode: response.statusCode, responseData: jsonDecode(response.body), isSuccess: false, errorMessage: jsonDecode(response.body));
      }

    }catch(e){
      return ApiResponse(responseCode: -1, responseData: null, isSuccess: false, errorMessage:e.toString());

    }

  }
}