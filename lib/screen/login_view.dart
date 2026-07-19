import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_manager/widget/custom_bg.dart';

import '../widget/custom_button.dart';
import '../widget/custom_text_field.dart';

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
            Text("Get Started With", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),),
            SizedBox(height: 20,),
            CustomTextField(labelText: 'email',),
            SizedBox(height: 15,),
            CustomTextField(labelText: 'password',),
            SizedBox(height: 15,),
            CustomButton(onTap: () { },)

          ],
        ),
      ))),
    );
  }
}


