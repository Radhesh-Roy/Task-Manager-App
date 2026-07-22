import 'package:flutter/material.dart';

class NewTaskView extends StatefulWidget {
  const NewTaskView({super.key});

  @override
  State<NewTaskView> createState() => _NewTaskViewState();
}

class _NewTaskViewState extends State<NewTaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body:SafeArea(
        child: Padding(padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    width: 82,
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),

                    child: Column(
                      children: [
                        Text("09", style: TextStyle(fontWeight: FontWeight.w600),),
                        Text("Cancelled", style: TextStyle(fontWeight: FontWeight.w400),),
                      ],
                    ),
                  );
              },

                    separatorBuilder:(context, index) {
                      return SizedBox(width: 5,);
                    },),
            )
          ],
        ),
        ),
      )
    );
  }
}
