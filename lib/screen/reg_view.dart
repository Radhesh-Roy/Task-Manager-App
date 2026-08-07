import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/data/model/api_response.dart';
import 'package:task_manager/data/service/api_caller.dart';
import 'package:task_manager/screen/login_view.dart';
import 'package:task_manager/utils/urls.dart';
import 'package:task_manager/widget/custom_bg.dart';
import 'package:task_manager/widget/custom_button.dart';
import 'package:task_manager/widget/custom_text_field.dart';
import 'package:task_manager/widget/custom_title.dart';

class RegistrationViewPage extends StatefulWidget {
  const RegistrationViewPage({super.key});

  @override
  State<RegistrationViewPage> createState() => _RegistrationViewPageState();
}

class _RegistrationViewPageState extends State<RegistrationViewPage> {
  
  Future<void>register() async {
    final ApiResponse response= await ApiCaller().postRequest(URL: TMUrls.SignupURL, body: {

      "email":emailController.text,
      "firstName":firstNameController.text,
      "lastName":lastNameController.text,
      "mobile":mobileController.text,
      "password":passwordController.text
    });

        if(response.isSuccess){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginView()));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Register Success")));

        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Register Failed")));

        }
  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController mobileController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Form(
        key: _formKey,
        child: SafeArea(
          child: CustomBackground(child:
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitle(title: "Join With Us",),
                    SizedBox(height: 20,),
                    CustomTextField(labelText: "email",
                        controller: emailController,

                        validator: (value){
              if(value == null || value.isEmpty){
              return 'Please enter email';
              }else{
              return null;
              }
              },),
                    SizedBox(height: 12,),
                    CustomTextField(labelText: "first name",
                      controller: firstNameController,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter first name';
                        }else{
                          return null;
                        }
                      },


                    ),
                    SizedBox(height: 12,),
                    CustomTextField(labelText: "last name",
                      controller: lastNameController,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter last name';
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 12,),
                    CustomTextField(labelText: "mobile",
                      controller: mobileController,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter mobile';
                        }else{
                          return null;
                        }
                      },

                    ),
                    SizedBox(height: 12,),
                    CustomTextField(
                      controller: passwordController,

                      labelText: "password",
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter password';
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 12,),
                    CustomButton(onTap: (){

                      if(_formKey.currentState!.validate()){
                        register();

                      }
                    },),
                    SizedBox(height: 12,),
                    Center(
                      child: RichText(text: TextSpan(children: [
                        TextSpan(text: "have an account?",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black54),
                            children: [
                              WidgetSpan(child: InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginView()));
                                  },
                                  child: Text(" Sign In", style: TextStyle(color: CupertinoColors.activeGreen, fontWeight: FontWeight.w600, fontSize: 16),)))
                            ]
                        ),
                      ])),
                    )
                ],),
              ),
            ),
          )),
        ),
      )
    );
  }
}
