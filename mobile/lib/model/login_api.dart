import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static final ngrokHeaders = "'ngrok-skip-browser-warning': 'true'";
  static final api = dotenv.env['API_URL'];
  String token;
  String msg;

  LoginApi({required this.token, required this.msg});

  factory LoginApi.createLoginApi(Map<String, dynamic> object) {
    return LoginApi(token: object['token'], msg: object['msg']);
  }

  static Future<LoginApi> login(String username, String password) async {
    String apiURL = '$api/auth/login';
    var apiResult = await http.post(Uri.parse(apiURL),
        body: {"username": username, "password": password},
        headers: {'ngrok-skip-browser-warning': 'true'});

    var loginResult = json.decode(apiResult.body);
    return LoginApi.createLoginApi(loginResult);
  }
}
