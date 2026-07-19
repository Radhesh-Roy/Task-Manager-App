import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({
    super.key,
  });

  @override

  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset("assets/bd.svg", fit: BoxFit.cover,)

      ],
    );
  }
}