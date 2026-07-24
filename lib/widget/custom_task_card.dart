import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_model.dart';

class CustomTaskCard extends StatelessWidget {
  final TaskModel taskModel;
  final Color statusColor;
  const CustomTaskCard({
    super.key, required this.taskModel, required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 145,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        title: Text("${taskModel.title}", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${taskModel.description}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis, maxLines: 2,),
            SizedBox(height: 5,),
            Text("Date: ${taskModel.createdDate}", style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w500),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(label: Text("${taskModel.status}", style: TextStyle(color: Colors.white),),
                  backgroundColor: statusColor,
                  shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit_note_outlined, color: Colors.green,)),
                SizedBox(width: 5,),
                IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline_outlined, color: Colors.red,)),

              ],
            )
          ],
        ),

      ),
    );
  }
}