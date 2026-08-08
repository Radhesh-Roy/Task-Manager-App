import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/model/user_model.dart';
import 'package:task_manager/data/service/api_caller.dart';
import 'package:task_manager/screen/cancel_task_view.dart';
import 'package:task_manager/screen/complete_task_view.dart';
import 'package:task_manager/screen/new_task_view.dart';
import 'package:task_manager/screen/progress_task_view.dart';
import 'package:task_manager/screen/update_profile_view.dart';
import 'package:task_manager/utils/urls.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({super.key});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  List<UserModel> profileDetails=[];
  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void>getUser()async{
    final response= await ApiCaller().getRequest(URL: TMUrls.profileDetails);
    List<UserModel> tempList=[];

    if(response.isSuccess){
      for(Map<String, dynamic>jsonData in response.responseData['data']){
        tempList.add(UserModel.fromJson(jsonData));

    }
    setState(() {
      profileDetails=tempList;
    });

    }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.responseData["data"])));

    }

    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


  }



  int selectedIndex=0;
  List screens=[
    NewTaskView(),
    ProgressTaskView(),
    CancelTaskView(),
    CompleteTaskView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Radhesh", style: TextStyle(fontSize: 17, color: Colors.white),),
            Text("radheshroy0011@gmail.com",style: TextStyle(fontSize: 14, color: Colors.white),),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfileView()));
            },
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/splash.png",),
            ),
          ),
        ),
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
          onDestinationSelected: (int index){
          selectedIndex=index;
          },
          destinations:[
        NavigationDestination(icon: Icon(Icons.task_outlined), label: "New Task"),
        NavigationDestination(icon: Icon(Icons.refresh_outlined), label: "Progress"),
        NavigationDestination(icon: Icon(Icons.cancel_outlined), label: "Cancel"),
        NavigationDestination(icon: Icon(Icons.task_alt_outlined), label: "Completed"),
      ])
    );
  }
