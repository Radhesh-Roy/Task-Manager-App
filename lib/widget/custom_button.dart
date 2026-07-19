import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  void Function()? onTap;
   CustomButton({
    super.key, required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(7)
        ),
        child: Padding(padding: EdgeInsets.all(0),
          child: Center(child: Icon(Icons.arrow_circle_right_outlined, color: Colors.white,),),),
      ),
    );
  }
}