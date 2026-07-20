import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  const CustomTextField({
    super.key, required this.labelText, this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none
        ),
        hoverColor: Colors.transparent,
        labelText: "$labelText",
      ),
    );
  }
}