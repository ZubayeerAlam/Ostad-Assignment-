
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Data/Controller/auth_controller.dart';
import '../Data/Model/Api_response.dart';
import '../Data/Model/UserModel.dart';
import '../Data/Service/Api_Caller.dart';
import '../Widget/App_Bar.dart';
import '../utils/Urls.dart';
import 'main_nav_Screen.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key, required String appBarTitle});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void>updateProfile() async {

    Map<String,dynamic> requestBody = {
      "email":emailController.text,
      "firstName":firstNameController.text,
      "lastName":lastNameController.text,
      "mobile":mobileController.text,
    };

    if(passwordController.text.isNotEmpty){
      requestBody['password'] = passwordController.text;
    }

    final ApiResponse response = await ApiCaller.PostRequest(url: urls.updateProfileURL,
        body: requestBody

    );


    if(response.isSuccess){
      userModel user = userModel(
        sId: AuthController.userData?.sId,
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        mobile: mobileController.text,
      );

      AuthController.updateUserData(user);
      AuthController.getUserData();

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainNavScreen()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up success....!')));


    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.responseData['data'])));

    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel user = AuthController.userData!;


    emailController.text = user.email!;
    firstNameController.text = user.firstName!;
    lastNameController.text = user.lastName!;
    mobileController.text = user.mobile!;
  }

  @override
  Widget build(BuildContext context) {
    final String fullName = AuthController.userData!.firstName! + ' ' + AuthController.userData!.lastName!;
    final String email = AuthController.userData!.email!;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar(appBarTitle: 'Profile', showSearch: false,),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: Color(0xFFBDBDBD),
                  child: Icon(Icons.person, size: 36, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Form(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              key: formkey,
              children: [
                Text("Email", style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,)),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 12),

                Text("First Name", style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,)),
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 12),


                Text("Last Name", style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,)),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 12),


                Text("Phone Number", style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,)),
                TextFormField(
                  controller: mobileController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 12),


                Text("Password", style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,)),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 12),
              ]
            )),

            const SizedBox(height: 22),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  updateProfile();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainNavScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}