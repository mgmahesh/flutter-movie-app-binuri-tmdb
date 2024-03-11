import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app_example/client/firebas_auth.dart';
import 'package:movie_app_example/constants/colors.dart';

import '../../components/show_dialog.dart';

Future<dynamic> EditUser(BuildContext context) {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final double statusBarHeight = MediaQuery.of(context).padding.top;
  final double navigationBarHeight = MediaQuery.of(context).padding.bottom;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  File? _image;

  Future<void> _getImageFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
  }

  return showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    elevation: 0,
    backgroundColor: Colours.scaffoldBgColor,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: navigationBarHeight,
              left: 12.0,
              right: 12.0,
              top: statusBarHeight + 12.0,
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel_outlined),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: displayNameController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15,
                          ),
                          hintText: "Display Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15,
                          ),
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15,
                          ),
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _getImageFromCamera,
                        child: Text('Take Photo'),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                var email = emailController.text;
                                var password = passwordController.text;
                                var displayName = displayNameController.text;
                                User? user = await _authService.editUser(
                                    email: email,
                                    password: password,
                                    displayName: displayName,
                                    photoURL:
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Mukesh_Ambani.jpg/200px-Mukesh_Ambani.jpg');
                                if (user != null) {
                                  Navigator.pop(context);
                                  showCustomDialog(context,
                                      title: 'Edit Successful',
                                      content: 'Enjoy this app',
                                      buttonText: 'OK');
                                } else {
                                  showCustomDialog(context,
                                      title: 'Edit Failed',
                                      content: 'Please try again.',
                                      buttonText: 'OK');
                                }
                              },
                              child: Text("Update Profile"),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
