import 'dart:convert';
import 'package:clickchic_app/Screen/profile.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Main AccountScreen class for viewing user details
class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = getLoggedInCustomerData();
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<User> getLoggedInCustomerData() async {
    String? token = await _getToken();

    if (token == null) {
      throw Exception('No authentication token found');
    }

    var response = await http.get(
      Uri.http('10.0.2.2:8000', 'api/customer'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return User(
        firstname: jsonData["first_name"] ?? 'N/A',
        lastname: jsonData["last_name"] ?? 'N/A',
        username: jsonData["username"] ?? 'N/A',
        email: jsonData["email"] ?? 'N/A',
        address: jsonData["address"] ?? 'N/A', // Added address field
      );
    } else {
      throw Exception('Failed to load customer data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            // Navigate back to the ProductPage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
        title: const Text('Account Details'),
      ),
      body: FutureBuilder<User>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            User user = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Account Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 1),
                  _buildDetailRow('First Name', user.firstname),
                  const Divider(thickness: 1),
                  _buildDetailRow('Last Name', user.lastname),
                  const Divider(thickness: 1),
                  _buildDetailRow('Username', user.username),
                  const Divider(thickness: 1),
                  _buildDetailRow('Email', user.email),
                  const Divider(thickness: 1),
                  _buildDetailRow('Address', user.address),
                  const Divider(thickness: 1),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text('Edit Details'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditAccountScreen(user: user),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data found.'));
          }
        },
      ),
    );
  }

  Widget _buildDetailRow(String fieldName, String fieldValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fieldName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            fieldValue,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// EditAccountScreen class for editing user details
class EditAccountScreen extends StatefulWidget {
  final User user;

  const EditAccountScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _firstname, _lastname, _username, _email, _address;

  @override
  void initState() {
    super.initState();
    _firstname = widget.user.firstname;
    _lastname = widget.user.lastname;
    _username = widget.user.username;
    _email = widget.user.email;
    _address = widget.user.address;
  }

  Future<void> _updateAccount() async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) return;

    _formKey.currentState?.save();

    String? token = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getString('token'));

    if (token == null) {
      throw Exception('No authentication token found');
    }

    var response = await http.put(
      Uri.http('10.0.2.2:8000', 'api/customer/update'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "first_name": _firstname,
        "last_name": _lastname,
        "username": _username,
        "email": _email,
        "address": _address, // Send the updated address to the backend
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context); // Go back to the account screen after updating
    } else {
      throw Exception('Failed to update account details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                label: 'First Name',
                initialValue: _firstname,
                onSaved: (value) => _firstname = value!,
              ),
              _buildTextField(
                label: 'Last Name',
                initialValue: _lastname,
                onSaved: (value) => _lastname = value!,
              ),
              _buildTextField(
                label: 'Username',
                initialValue: _username,
                onSaved: (value) => _username = value!,
              ),
              _buildTextField(
                label: 'Email',
                initialValue: _email,
                onSaved: (value) => _email = value!,
              ),
              _buildTextField(
                label: 'Address',
                initialValue: _address,
                onSaved: (value) => _address = value!,
              ),
              const SizedBox(height: 10),

              // Button to get current location and update the address

              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Save Changes'),
                onPressed: _updateAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required FormFieldSetter<String> onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(labelText: label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }
}

// User class with an address field
class User {
  final String firstname, lastname, username, email;
  String address;

  User({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.address,
  });
}
