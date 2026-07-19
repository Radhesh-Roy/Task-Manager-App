import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  const CustomBackground({
    super.key, required this.child,
  });

  @override

  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          width: double.maxFinite,
          height: double.maxFinite,
          "assets/bd.svg",
          fit: BoxFit.cover,),
        child

      ],
    );
  }
}