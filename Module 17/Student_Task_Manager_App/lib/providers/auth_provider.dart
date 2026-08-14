import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../Data/Controller/auth_controller.dart';
import '../Data/Model/Api_response.dart';
import '../Data/Model/UserModel.dart';
import '../Data/Service/Api_Caller.dart';
import '../utils/Urls.dart';

class AuthProvider extends ChangeNotifier {
  bool isLogin = false;
  String ? errorMassage;

  void setLogin(bool value) {
    isLogin = value;
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    final ApiResponse response = await ApiCaller.PostRequest(
      url: urls.signInURL,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.isSuccess) {

      userModel model = userModel.fromJson(response.responseData['data']);
      String token = response.responseData['token'];

      AuthController.saveUserData(model, token);

      return true;
    } else{
     return false;
    }
  }


  Future<bool> signUp(String email, String firstName, String lastName, String mobile, String password) async {

    final ApiResponse response = await ApiCaller.PostRequest(
        url: urls.signUPURL,
        body: {
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'mobile': mobile,
          'password': password,
        }
    );

    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}