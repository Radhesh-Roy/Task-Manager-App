import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screen/login_view.dart';
import 'package:task_manager/widget/custom_bg.dart';
import 'package:task_manager/widget/custom_button.dart';
import 'package:task_manager/widget/custom_text_field.dart';
import 'package:task_manager/widget/custom_title.dart';

class RegistrationViewPage extends StatefulWidget {
  const RegistrationViewPage({super.key});

  @override
  State<RegistrationViewPage> createState() => _RegistrationViewPageState();
}

class _RegistrationViewPageState extends State<RegistrationViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:CustomBackground(child:
      Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          CustomTitle(title: "Join with us"),
          SizedBox(height: 20,),
            CustomTextField(labelText: "email"),
            SizedBox(height: 12,),
            CustomTextField(labelText: "first name"),
            SizedBox(height: 12,),
            CustomTextField(labelText: "last name"),
            SizedBox(height: 12,),
            CustomTextField(labelText: "mobile"),
            SizedBox(height: 12,),
            CustomTextField(labelText: "password"),
            SizedBox(height: 12,),
            CustomButton(onTap: (){},),
            SizedBox(height: 12,),
            Center(
              child: RichText(text: TextSpan(children: [

                TextSpan(text: "have an account?",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    children: [
                      WidgetSpan(child: InkWell(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginView()));
                          },
                          child: Text(" Sign In", style: TextStyle(color: CupertinoColors.activeGreen, fontWeight: FontWeight.w600, fontSize: 16),)))
                    ]
                ),
              ])),
            )

        ],),
      ))
    );
  }
}
