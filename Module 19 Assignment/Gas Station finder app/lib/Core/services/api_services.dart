import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  Future<dynamic> get(String url) async {
    try {

      final response = await http.get(Uri.parse(url));
      if( response.statusCode ==200){
        return jsonDecode(response.body);
      }else{
        throw Exception("Error making Get request to $url : ${response.statusCode}");
      }

    } catch (e) {
      throw Exception("Error making Get request to $url : $e");
    }
  }
}
