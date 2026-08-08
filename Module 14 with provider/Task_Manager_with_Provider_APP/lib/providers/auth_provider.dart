import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Data/Controller/auth_controller.dart';
import '../Data/Model/Api_response.dart';
import '../Data/Model/UserModel.dart';
import '../Data/Service/Api_Caller.dart';
import '../Utils/Urls.dart';

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

}