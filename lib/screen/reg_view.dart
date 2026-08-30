import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/provider/auth_provider.dart';
import '../screen/login_view.dart';
import '../widget/custom_bg.dart';
import '../widget/custom_button.dart';
import '../widget/custom_text_field.dart';
import '../widget/custom_title.dart';

class RegistrationViewPage extends StatefulWidget {
  const RegistrationViewPage({super.key});

  @override
  State<RegistrationViewPage> createState() =>
      _RegistrationViewPageState();
}

class _RegistrationViewPageState
    extends State<RegistrationViewPage> {

  final GlobalKey<FormState> _formKey =
  GlobalKey<FormState>();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController firstNameController =
  TextEditingController();

  final TextEditingController lastNameController =
  TextEditingController();

  final TextEditingController mobileController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40),

                child: Center(
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      CustomTitle(
                        title: "Join With Us",
                      ),

                      const SizedBox(height: 20),

                      CustomTextField(
                        labelText: "email",
                        controller: emailController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      CustomTextField(
                        labelText: "first name",
                        controller: firstNameController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      CustomTextField(
                        labelText: "last name",
                        controller: lastNameController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      CustomTextField(
                        labelText: "mobile",
                        controller: mobileController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Please enter mobile';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      CustomTextField(
                        labelText: "password",
                        controller: passwordController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      Consumer<AuthProvider>(
                        builder: (context, provider, child) {

                          if (provider.isLoading) {
                            return const Center(
                              child:
                              CircularProgressIndicator(),
                            );
                          }

                          return CustomButton(
                            onTap: () async {

                              if (_formKey.currentState!
                                  .validate()) {

                                final success =
                                await context
                                    .read<AuthProvider>()
                                    .register(
                                  email:
                                  emailController
                                      .text,

                                  firstName:
                                  firstNameController
                                      .text,

                                  lastName:
                                  lastNameController
                                      .text,

                                  mobile:
                                  mobileController
                                      .text,

                                  password:
                                  passwordController
                                      .text,
                                );

                                if (!context.mounted) {
                                  return;
                                }

                                if (success) {

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                      const LoginView(),
                                    ),
                                  );

                                  ScaffoldMessenger.of(
                                      context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Register Success",
                                      ),
                                    ),
                                  );

                                } else {

                                  ScaffoldMessenger.of(
                                      context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Register Failed",
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 12),

                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [

                              const TextSpan(
                                text: "have an account? ",

                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.w600,
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
                                        builder: (_) =>
                                        const LoginView(),
                                      ),
                                    );
                                  },

                                  child: const Text(
                                    "Sign In",

                                    style: TextStyle(
                                      color: CupertinoColors
                                          .activeGreen,
                                      fontWeight:
                                      FontWeight.w600,
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
        ),
      ),
    );
  }
}