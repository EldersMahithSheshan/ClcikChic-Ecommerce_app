import 'dart:convert';
import 'package:clickchic_app/Services/globals.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<http.Response> Register(
      String first_name,
      String last_name,
      String username,
      String email,
      String phone_number,
      String password) async {
    Map data = {
      'first_name': first_name,
      'last_name': last_name,
      'username': username,
      'email': email,
      'phone_number': phone_number,
      'password': password,
    };

    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/register');
    http.Response response = await http.post(url, headers: headers, body: body);

    print(response.body);
    return response;
  }

  static Future<http.Response> Login(String email, String password) async {
    Map data = {'email': email, 'password': password};

    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/login');
    http.Response response = await http.post(url, headers: headers, body: body);

    print(response.body);
    return response;
  }
}
