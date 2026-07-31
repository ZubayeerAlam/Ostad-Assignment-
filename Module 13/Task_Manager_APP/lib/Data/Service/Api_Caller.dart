import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_manager_app/Data/Model/Api_response.dart';
import 'package:http/http.dart';
class ApiCaller {
  static Future<ApiResponse>getRequest({required String url}) async {
    Response response = await get(Uri.parse(url),
        headers: {
          'token' : ''
        }

    );

    if(response.statusCode ==200){
      return ApiResponse(responseCode: response.statusCode, responseData: jsonDecode(response.body), isSuccess: true, errorMessage: '');
    }else{
      return ApiResponse(responseCode: response.statusCode, responseData: jsonDecode(response.body), isSuccess: false, errorMessage: jsonDecode(response.body));
    }
  }

  static Future<ApiResponse>postRequest({required String url, required Map<String, dynamic> body}) async {
    Response response = await post(Uri.parse(url),
        headers: {
          'token' : '',
          'Content-Type' : 'application/json',
          'Accept' : 'application/json'
        },
        body: body != null? jsonEncode(body) : null
    );
    if(response.statusCode ==200 || response.statusCode ==201){
      return ApiResponse(responseCode: response.statusCode, responseData: jsonDecode(response.body), isSuccess: true, errorMessage: '');
    }else{
      return ApiResponse(responseCode: response.statusCode, responseData: jsonDecode(response.body), isSuccess: false, errorMessage: jsonDecode(response.body));
    }
  }

}