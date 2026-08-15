import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/Screen/main_nav_Screen.dart';
import 'package:task_manager_app/Screen/sign_up_screen.dart';
import 'package:task_manager_app/Widget/ScreenBG.dart';
import 'package:task_manager_app/providers/auth_provider.dart';
import '../Utils/app_colors.dart';
import 'Add_Email_Screen.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _State();
}

class _State extends State<Login_Screen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void>signIn()async{
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool isLogin = await authProvider.signIn(emailController.text, passwordController.text);

    if(isLogin){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainNavScreen()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up success....!')));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(authProvider.errorMassage ?? "Something went wrong")));
    }
  }


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
                "Get Started With",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Enter Your Email"),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: "Enter Your Password"),
              ),

              SizedBox(height: 16),

              FilledButton(
                onPressed: () {
                  signIn();
                },
                child: Icon(Icons.arrow_circle_right_outlined, size: 28),
              ),

              SizedBox(height: 48),

              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Add_Email()),
                        );
                      },
                      child: Text(
                        'Forget Password ?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),

                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: AppColors.PColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                              ),
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
