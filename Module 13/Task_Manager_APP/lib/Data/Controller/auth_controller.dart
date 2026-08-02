import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/Data/Model/UserModel.dart';

class AuthController {
  static String? accessToken;
  static String? userData;

  static Future saveUserData(userModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('userData', jsonEncode(model.toJson()));
    sharedPreferences.setString('accessToken', token);

    accessToken = token;
    userData = model.toJson().toString();
  }

  static Future getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? user =sharedPreferences.getString('userData');
    String? token = sharedPreferences.getString('accessToken');

    if(token!=null){
      accessToken=token;
    }
    if(user!=null && user.isNotEmpty){
      userData=user;
    }
  }


  static Future<bool> isUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String ? token = sharedPreferences.getString('token');

    return token != null;

  }




}
