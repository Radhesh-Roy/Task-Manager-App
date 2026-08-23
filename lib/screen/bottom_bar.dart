import 'package:flutter/material.dart';
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
  List<UserModel> profileDetails = [];
  int selectedIndex = 0;

  final List<Widget> screens = [
    const NewTaskView(),
    const ProgressTaskView(),
    const CancelTaskView(),
    const CompleteTaskView(),
  ];
  @override
  void initState() {
    super.initState();

    getUser();
  }
  Future<void> getUser() async {
    final response = await ApiCaller().getRequest(
      URL: TMUrls.profileDetails,
    );
    if (response.isSuccess) {
      List<UserModel> tempList = [];

      for (Map<String, dynamic> jsonData
      in response.responseData['data']) {
        tempList.add(
          UserModel.fromJson(jsonData),
        );
      }

      if (!mounted) return;

      setState(() {
        profileDetails = tempList;
      });
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.responseData["data"].toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        elevation: 0,
        scrolledUnderElevation: 0,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Radhesh",
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            Text(
              "radheshroy0011@gmail.com",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),

        leading: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 5,
            bottom: 5,
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateProfileView(),
                ),
              );
            },
            child: const CircleAvatar(
              backgroundImage: AssetImage(
                "assets/splash.png",
              ),
            ),
          ),
        ),
      ),

      body: screens[selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,

        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.task_outlined),
            label: "New Task",
          ),
          NavigationDestination(
            icon: Icon(Icons.refresh_outlined),
            label: "Progress",
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: "Cancel",
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            label: "Completed",
          ),
        ],
      ),
    );
  }
}