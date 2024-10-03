import 'dart:convert';
import 'dart:io'; // Import for File
import 'package:clickchic_app/Screen/Cart-page.dart';
import 'package:clickchic_app/Screen/account.dart';
import 'package:clickchic_app/Screen/loging.dart';
import 'package:clickchic_app/Screen/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import for Image Picker
import 'package:clickchic_app/Screen/product_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart'; // Import for permissions

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Function to fetch user data
  Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      return json.decode(userJson);
    }

    return {};
  }

  // Save the image path in SharedPreferences
  Future<void> saveImagePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image_path', path);
  }

  // Load the image path from SharedPreferences
  Future<void> loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image_path');
    setState(() {
      if (imagePath != null) {
        _imageFile = File(imagePath);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Load the saved image when the profile screen initializes
    loadImage();
  }

  // Function to handle photo selection
  Future<void> takePhoto(ImageSource source) async {
    final permissionStatus = await _checkPermission(source);

    if (permissionStatus) {
      final pickedFile = await _picker.pickImage(source: source);
      setState(() {
        _imageFile = pickedFile != null ? File(pickedFile.path) : null;
      });

      // Save the picked image path to SharedPreferences
      if (_imageFile != null) {
        await saveImagePath(_imageFile!.path);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission denied')),
      );
    }
  }

  // Check for camera and gallery permissions
  Future<bool> _checkPermission(ImageSource source) async {
    if (source == ImageSource.camera) {
      var status = await Permission.camera.request();
      return status == PermissionStatus.granted;
    } else {
      var status = await Permission.photos.request();
      return status == PermissionStatus.granted;
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
                Navigator.pop(context); // Close the bottom sheet
              },
              label: const Text("Camera"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
                Navigator.pop(context); // Close the bottom sheet
              },
              label: const Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            backgroundImage: _imageFile == null
                ? const AssetImage("assets/profile.jpg") as ImageProvider
                : FileImage(_imageFile!),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: const Icon(
                Icons.camera_alt,
                color: Colors.teal,
                size: 28.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(title: ''),
              ),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No user data available'));
          }

          var user = snapshot.data!;
          var username = user['username'] ?? 'Username';
          var email = user['email'] ?? 'Email';

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture with option to change
                  imageProfile(),
                  const SizedBox(height: 20),

                  // Username and Email centered
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          username,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),

                  // Account Options
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Account'),
                          leading: const Icon(Icons.person),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccountScreen(),
                              ),
                            );
                          },
                        ),
                        const ListTile(
                          title: Text('Settings'),
                          leading: Icon(Icons.settings),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        const ListTile(
                          title: Text('Notification'),
                          leading: Icon(Icons.notifications_active),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        const ListTile(
                          title: Text('Help'),
                          leading: Icon(Icons.help),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        const ListTile(
                          title: Text('Share'),
                          leading: Icon(Icons.share),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        ListTile(
                          title: const Text('Logout'),
                          leading: const Icon(Icons.logout),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: NavigationBar(
            height: 60,
            selectedIndex: 3,
            backgroundColor: Colors.transparent,
            onDestinationSelected: (int index) {
              switch (index) {
                case 0:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPage(title: 'Home'),
                    ),
                  );
                  break;
                case 1:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ),
                  );
                  break;
                case 2:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationPage(),
                    ),
                  );
                  break;
                case 3:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                  break;
              }
            },
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              NavigationDestination(
                icon: Icon(Icons.notifications_active),
                label: 'Notification',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
