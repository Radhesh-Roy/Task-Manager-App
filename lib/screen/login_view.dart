import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screen/bottom_bar.dart';
import 'package:task_manager/screen/reg_view.dart';
import 'package:task_manager/widget/custom_bg.dart';

import '../data/model/api_response.dart';
import '../data/service/api_caller.dart';
import '../utils/urls.dart';
import '../widget/custom_button.dart';
import '../widget/custom_text_field.dart';
import '../widget/custom_title.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  Future<void>login() async {
    final ApiResponse response= await ApiCaller().postRequest(URL: TMUrls.LoginURL, body: {

      "email":emailController.text,
      "password":passwordController.text
    });

    if(response.isSuccess){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomBarView()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Success")));

    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed")));

    }
  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(child: CustomBackground(child: Padding(padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(title: 'Get Started With',),
              SizedBox(height: 20,),
              CustomTextField(labelText: 'email',
                controller: emailController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter email';
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 15,),
              CustomTextField(labelText: 'password',
                controller: passwordController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter password';
                  }else{
                    return null;
                  }
                },

              ),
              SizedBox(height: 15,),
              CustomButton(onTap: () {
                if(_formKey.currentState!.validate()){
                  login();

                }
              },),
              SizedBox(height: 20,),
              Center(child: Text("Forgot Password?", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),)),
              SizedBox(height: 10,),
              Center(
                child: RichText(text: TextSpan(children: [

                  TextSpan(text: "Don't have an account?",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black54),
                    children: [
                      WidgetSpan(child: InkWell(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationViewPage()));
                          },
                          child: Text(" Sign Up", style: TextStyle(color: CupertinoColors.activeGreen, fontWeight: FontWeight.w600, fontSize: 16),)))
                    ]
                  ),
                ])),
              )
            ],
          ),
        ))),
      ),
    );
  }
}


