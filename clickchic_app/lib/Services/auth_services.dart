import 'dart:convert';
import 'package:clickchic_app/Services/globals.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Register a new user
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

  // Login user and save token
  static Future<http.Response> Login(String email, String password) async {
    Map data = {'email': email, 'password': password};

    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/login');
    http.Response response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      String token = responseData['token'];

      // Save token to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    }

    print(response.body);
    return response;
  }

  // Fetch user data from the server
  static Future<http.Response> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    var url = Uri.parse(baseURL + 'user');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Add Bearer token
      },
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  // Update user details
  static Future<http.Response> updateUser(String firstname, String lastname,
      String username, String email, String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    Map data = {
      'first_name': firstname,
      'last_name': lastname,
      'username': username,
      'email': email,
      'phone': phone,
    };

    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'customers/update');
    var response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Add Bearer token
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to update user');
    }
  }

  // Delete account
  static Future<http.Response> deleteAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    var url = Uri.parse(baseURL + 'customers/delete');
    var response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Add Bearer token
      },
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to delete account');
    }
  }
}
