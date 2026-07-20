import 'package:flutter/cupertino.dart';

class CustomTitle extends StatelessWidget {
 final String title;
  const CustomTitle({
    super.key, required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Text("$title", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),);
  }
}