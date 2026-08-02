import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/Widget/ScreenBG.dart';

import '../Data/Model/Api_response.dart';
import '../Data/Service/Api_Caller.dart';
import '../Utils/Urls.dart';
import '../Utils/app_colors.dart';
import 'Add_Email_Screen.dart';
import 'log_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signUp() async {

    final ApiResponse response = await ApiCaller.postRequest(
      url: urls.signUPURL,
      body: {
        'email': emailController.text,
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'mobile': mobileController.text,
        'password': passwordController.text,
      }
    );

    if (response.isSuccess) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Screen()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Sign Up Successful"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.responseData['data'])),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen_BG(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: fromKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Join With Us",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(hintText: "First Name"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(hintText: "Last Name"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: mobileController,
                  decoration: InputDecoration(hintText: "Mobile"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(hintText: "Password"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                FilledButton(
                  onPressed: () {
                    if (fromKey.currentState!.validate()) {
                      signUp();
                    }
                  },
                  child: Icon(Icons.arrow_circle_right_outlined, size: 28),
                ),

                SizedBox(height: 48),

                Center(
                  child: Column(
                    children: [

                      RichText(text: TextSpan(
                          text: "have an account? ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: 'Sign In', style: TextStyle(
                                color: AppColors.PColor,
                                fontWeight: FontWeight.bold
                            ),
                              recognizer: TapGestureRecognizer()..onTap=()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Screen())),


                            )
                          ]
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}
