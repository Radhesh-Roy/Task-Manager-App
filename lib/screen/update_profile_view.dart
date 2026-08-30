import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/provider/profile_provider.dart';
import '../widget/custom_bg.dart';
import '../widget/custom_button.dart';
import '../widget/custom_text_field.dart';
import '../widget/custom_title.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // =========================
    // GET PROFILE DATA
    // =========================

    Future.microtask(() {
      context.read<ProfileProvider>().getUser();
    });
  }

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
      body: Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          // =========================
          // LOADING
          // =========================

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // =========================
          // SET PROFILE DATA
          // =========================

          if (provider.userModel != null && emailController.text.isEmpty) {
            emailController.text = provider.userModel!.email ?? "";

            firstNameController.text = provider.userModel!.firstName ?? "";

            lastNameController.text = provider.userModel!.lastName ?? "";

            mobileController.text = provider.userModel!.mobile ?? "";
          }

          return CustomBackground(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    CustomTitle(title: "Update Profile"),
                    SizedBox(height: 15),
                    //email
                    CustomTextField(
                      labelText: "email",
                      controller: emailController,
                    ),
                    SizedBox(height: 10),
                    //first name
                    CustomTextField(
                      labelText: "first name",
                      controller: firstNameController,
                    ),
                    SizedBox(height: 10),
                    //last name
                    CustomTextField(
                      labelText: "last name",
                      controller: lastNameController,
                    ),
                    SizedBox(height: 10),
                    //mobile
                    CustomTextField(
                      labelText: "mobile",
                      controller: mobileController,
                    ),
                    SizedBox(height: 10),
                    //password
                    CustomTextField(
                      labelText: "password",
                      controller: passwordController,
                    ),
                    SizedBox(height: 15),
                    provider.isUpdating
                        ? CircularProgressIndicator()
                        : CustomButton(
                            onTap: () async {
                              final success = await context.read<ProfileProvider>().updateProfile(
                                    email: emailController.text,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    mobile: mobileController.text,
                                    password: passwordController.text,
                                  );

                              if (!context.mounted) {
                                return;
                              }
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Profile Updated Successfully",
                                    ),
                                  ),
                                );

                                Navigator.pop(context);
                              }
                              else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Profile Update Failed"),
                                  ),
                                );
                              }
                            },
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
