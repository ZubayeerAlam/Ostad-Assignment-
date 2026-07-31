import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/Widget/ScreenBG.dart';

import '../Utils/app_colors.dart';
import 'Add_Email_Screen.dart';
import 'log_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen_BG(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                decoration: InputDecoration(hintText: "Email"),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(hintText: "First Name"),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(hintText: "Last Name"),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(hintText: "Mobile"),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(hintText: "Password"),
              ),
              SizedBox(height: 16),

              FilledButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Screen()));
                },
                child: Icon(Icons.arrow_circle_right_outlined, size: 28),
              ),

              SizedBox(height: 48),

              Center(
                child: Column(
                  children: [
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_Email()));

                    }, child: Text('Forget Password ?',style: TextStyle(color: Colors.grey),)),

                    RichText(text: TextSpan(
                        text: "Don't have an account? ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: 'Sign Up', style: TextStyle(
                              color: AppColors.PColor,
                              fontWeight: FontWeight.bold
                          ),

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
    );
  }
}
