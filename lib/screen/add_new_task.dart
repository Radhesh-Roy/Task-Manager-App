import 'package:flutter/material.dart';
import 'package:task_manager/widget/custom_bg.dart';
import 'package:task_manager/widget/custom_button.dart';
import 'package:task_manager/widget/custom_text_field.dart';
import 'package:task_manager/widget/custom_title.dart';

import '../data/model/api_response.dart';
import '../data/service/api_caller.dart';
import '../utils/urls.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> createTask() async {
    final ApiResponse response = await ApiCaller().postRequest(
      URL: TMUrls.createTask,
      body: {
        "title": titleController.text,
        "description": descriptionController.text,
        "status": "New",
      },
    );

    if (response.isSuccess) {
      ScaffoldMessenger.of(context,).showSnackBar(SnackBar(content: Text('New task added')));
    } else {
      ScaffoldMessenger.of(context,).showSnackBar(SnackBar(content: Text('Something wrong..!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle(title: "Add New Task"),
                SizedBox(height: 15),
                CustomTextField(
                  labelText: "Subject",
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter subject';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: TextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      } else {
                        return null;
                      }
                    },
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hoverColor: Colors.transparent,
                      labelText: "Description",
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                CustomButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await createTask();
                      Navigator.pop(context, true);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
