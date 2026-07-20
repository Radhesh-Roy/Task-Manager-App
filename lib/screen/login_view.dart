import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screen/reg_view.dart';
import 'package:task_manager/widget/custom_bg.dart';

import '../widget/custom_button.dart';
import '../widget/custom_text_field.dart';
import '../widget/custom_title.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: CustomBackground(child: Padding(padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitle(title: 'Get Started With',),
            SizedBox(height: 20,),
            CustomTextField(labelText: 'email',),
            SizedBox(height: 15,),
            CustomTextField(labelText: 'password',),
            SizedBox(height: 15,),
            CustomButton(onTap: () { },),
            SizedBox(height: 20,),
            Center(child: Text("Forgot Password?", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),)),
            SizedBox(height: 10,),
            Center(
              child: RichText(text: TextSpan(children: [

                TextSpan(text: "Don't have an account?",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
    );
  }
}


