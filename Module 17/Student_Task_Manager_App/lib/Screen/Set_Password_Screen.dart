import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:student_task_manager_app/Screen/Login_Screen.dart';
import '../Widget/ScreenBG.dart';
import '../utils/app_colors.dart';

class Set_Password_Screen extends StatefulWidget {
  const Set_Password_Screen({super.key});

  @override
  State<Set_Password_Screen> createState() => _Set_Password_ScreenState();
}

class _Set_Password_ScreenState extends State<Set_Password_Screen> {
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
                "Set Password",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text("Enter your new password to proceed with your account", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(hintText: "Password"),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(hintText: " Confirm Password"),
              ),

              SizedBox(height: 16),

              FilledButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>loginScreen()));
                },
                child: Text("Continue",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  color: Colors.white
                ),),
              ),

              SizedBox(height: 48),

              Center(
                child: Column(
                  children: [

                    RichText(text: TextSpan(
                        text: "Have an account? ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: 'Sign In', style: TextStyle(
                              color: AppColors.PColor,
                              fontWeight: FontWeight.bold
                          ),
                            recognizer: TapGestureRecognizer()..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (context) => loginScreen())),

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
