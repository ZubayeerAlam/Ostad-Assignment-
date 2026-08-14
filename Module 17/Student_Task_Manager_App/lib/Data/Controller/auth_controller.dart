import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../Model/UserModel.dart';

class AuthController {

  static String ? accessToken;
  static userModel? userData;



  static Future saveUserData(userModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('token', token);
    sharedPreferences.setString('user-data', jsonEncode(model.toJson()));

    accessToken = token;
    userData = model;
  }


  static Future getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String ? token = sharedPreferences.getString('token');

    if(token != null){
      accessToken = token;
    }

    String ? user = sharedPreferences.getString('user-data');

    if(user != null && user.isNotEmpty){
      userData = userModel.fromJson(jsonDecode(user));
    }



  }


  static Future<bool> usUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String ? token = sharedPreferences.getString('token');

    return token != null;




  }


  static Future<void> updateUserData(userModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('user-data', jsonEncode(user.toJson()));

  }

}