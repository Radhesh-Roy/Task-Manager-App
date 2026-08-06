import 'package:flutter/material.dart';
import 'package:task_manager/widget/custom_bg.dart';
import 'package:task_manager/widget/custom_button.dart';
import 'package:task_manager/widget/custom_text_field.dart';
import 'package:task_manager/widget/custom_title.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(child: Padding(padding: EdgeInsets.all(40),
      child: Column(
        children: [
          CustomTitle(title: "Update Profile"),
          SizedBox(height: 15,),
          CustomTextField(labelText: "email"),
          SizedBox(height: 10,),
          CustomTextField(labelText: "first name"),
          SizedBox(height: 10,),
          CustomTextField(labelText: "last name"),
          SizedBox(height: 10,),
          CustomTextField(labelText: "mobile"),
          SizedBox(height: 10,),
          CustomTextField(labelText: "password"),
          SizedBox(height: 10,),
          CustomButton(onTap: (){})
        ],
      ),
      
      )),
    );
  }
}
