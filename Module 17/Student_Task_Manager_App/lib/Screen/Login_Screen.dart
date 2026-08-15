import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_task_manager_app/Screen/signUp_screen.dart';
import 'package:student_task_manager_app/Widget/screenBG.dart';

import '../Widget/appBG.dart';
import '../providers/auth_provider.dart';
import '../utils/app_colors.dart';
import 'main_nav_Screen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void>signIn()async{
    final authProvider = Provider.of<AuthProvider>(context,listen: false);

    bool login = await authProvider.signIn(emailController.text, passwordController.text);

    if(login){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign In success....!')),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.errorMassage ?? 'Sign In failed!')),
      );
    }
  }


  void onTapSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return appBG(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 250,),
              Text('Get Started With', style: Theme.of(context).textTheme.titleLarge,),
              SizedBox(height: 25,),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'Email'
                ),
              ),
              SizedBox(height: 10,),

              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
              ),

              FilledButton(onPressed: (){
                signIn();
              }, child: Icon(Icons.arrow_circle_right_outlined,size: 25,)),

              SizedBox(height: 35,),

              Center(
                child: Column(
                  children: [
                    TextButton(onPressed: (){}, child: Text('Forget Password ?',style: TextStyle(color: Colors.grey),)),

                    RichText(text: TextSpan(
                        text: "Don't have an account? ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                              text: 'Sign Up', style: TextStyle(
                              color: AppColors.PColor,
                              fontWeight: FontWeight.bold
                          ),
                              recognizer: TapGestureRecognizer()..onTap = onTapSignUp
                          )
                        ]
                    ))
                  ],
                ),
              )

            ],
          ),
        )
    );
  }
}
