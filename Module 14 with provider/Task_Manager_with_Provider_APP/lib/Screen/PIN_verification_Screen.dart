import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/Widget/ScreenBG.dart';

import '../Utils/app_colors.dart';
import 'Set_Password_Screen.dart';
import 'log_in_screen.dart';

class Pin_verification extends StatefulWidget {
  const Pin_verification({super.key});

  @override
  State<Pin_verification> createState() => _State();
}

class _State extends State<Pin_verification> {
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
                "Pin Verification",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),

              Text(
                "A 6 digit code will be sent to your email address for verification",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              SizedBox(height: 16),

              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        )
                    ),
                    SizedBox(width: 8),
                    Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        )
                    ),
                    SizedBox(width: 8),
                    Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        )
                    ),
                    SizedBox(width: 8),
                    Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        )
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              FilledButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Set_Password_Screen()));
                },
                child: Text("Verify",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),),
              ),

              SizedBox(height: 48),

              Center(
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Have account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: AppColors.PColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login_Screen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
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
