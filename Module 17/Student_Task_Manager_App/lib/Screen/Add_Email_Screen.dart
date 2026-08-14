
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:student_task_manager_app/Screen/signUp_Screen.dart';

import '../Widget/ScreenBG.dart';
import '../utils/app_colors.dart';
import 'PIN_verification_Screen.dart';

class Add_Email extends StatefulWidget {
  const Add_Email({super.key});

  @override
  State<Add_Email> createState() => _State();
}

class _State extends State<Add_Email> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenBG(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Email Address",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              
              Text("A 6 digit code will be sent to your email address for verification",style: TextStyle(color: Colors.grey.shade600),),
              SizedBox(height: 16),

              TextFormField(
                decoration: InputDecoration(hintText: "Enter Your Email"),
              ),
              SizedBox(height: 16),
              
              FilledButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Pin_verification()));
                },
                child: Icon(Icons.arrow_circle_right_outlined, size: 28),
              ),

              SizedBox(height: 48),

              Center(
                child: Column(
                  children: [
                    RichText(text: TextSpan(
                        text: "Have account? ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: 'Sign In', style: TextStyle(
                              color: AppColors.PColor,
                              fontWeight: FontWeight.bold
                          ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> signUpScreen()));
                            }
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
