import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/provider/auth_provider.dart';
import '../screen/bottom_bar.dart';
import '../screen/reg_view.dart';
import '../widget/custom_bg.dart';
import '../widget/custom_button.dart';
import '../widget/custom_text_field.dart';
import '../widget/custom_title.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,

        child: SafeArea(
          child: CustomBackground(
            child: Padding(
              padding: const EdgeInsets.all(40),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  CustomTitle(title: 'Get Started With'),

                  const SizedBox(height: 20),

                  CustomTextField(
                    labelText: 'email',
                    controller: emailController,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  CustomTextField(
                    labelText: 'password',
                    controller: passwordController,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  Consumer<AuthProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return CustomButton(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            final success = await context
                                .read<AuthProvider>()
                                .login(
                                  email: emailController.text,

                                  password: passwordController.text,
                                );

                            if (!context.mounted) {
                              return;
                            }

                            if (success) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BottomBarView(),
                                ),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content: Text("Login Success")),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content: Text("Login Failed")),
                              );
                            }
                          }
                        },
                      );
                    },
                  ),

                   SizedBox(height: 20),

                   Center(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                   SizedBox(height: 10),

                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                           TextSpan(
                            text: "Don't have an account? ",

                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),

                          WidgetSpan(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RegistrationViewPage(),
                                  ),
                                );
                              },

                              child: Text(
                                "Sign Up",

                                style: TextStyle(
                                  color: CupertinoColors.activeGreen,

                                  fontWeight: FontWeight.w600,

                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
