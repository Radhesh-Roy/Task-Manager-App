import 'package:flutter/material.dart';
import 'package:task_manager/widget/custom_bg.dart';
import 'package:task_manager/widget/custom_button.dart';
import 'package:task_manager/widget/custom_text_field.dart';
import 'package:task_manager/widget/custom_title.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitle(title: "Add New Task"),
           SizedBox(height: 15,),
           CustomTextField(labelText: "Subject"),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: TextFormField(
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hoverColor: Colors.transparent,
                  labelText: "Description",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            CustomButton(onTap: (){},  )
          ],
        ),
      )),
    );
  }
}
