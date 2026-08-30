import 'package:flutter/material.dart';
import 'package:task_manager/screen/login_view.dart';
import '../controller/auth_controller.dart';
import '../widget/custom_bg.dart';
import 'bottom_bar.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {

  Future<void>nextScreen()async{
    await Future.delayed(Duration(seconds: 3));
    AuthController.getUserData();
    final bool isLogin = await AuthController.isUserLogin();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => isLogin
            ? const BottomBarView()
            : const LoginView(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nextScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(child: Center(child: Padding(
        padding: const EdgeInsets.all(20),
        child: Image.asset("assets/splash.png"),
      ),),),

    );
  }
}


