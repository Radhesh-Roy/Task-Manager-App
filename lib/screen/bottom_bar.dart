import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/screen/cancel_task_view.dart';
import 'package:task_manager/screen/complete_task_view.dart';
import 'package:task_manager/screen/new_task_view.dart';
import 'package:task_manager/screen/progress_task_view.dart';
import 'package:task_manager/screen/update_profile_view.dart';

import '../controller/provider/profile_provider.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({super.key});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
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

    Future.microtask(() {context.read<ProfileProvider>().getUser();});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            final user = provider.userModel;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.firstName ?? "User",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),

                Text(
                  user?.email ?? "",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            );
          },
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
          child: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProfileView(),
                ),
              );
            },

            child: CircleAvatar(
              backgroundImage: AssetImage("assets/splash.png"),
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

        destinations:[
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
