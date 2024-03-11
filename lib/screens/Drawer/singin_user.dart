import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_example/client/firebas_auth.dart';
import 'package:movie_app_example/constants/colors.dart';

import '../../components/show_dialog.dart';

Future<dynamic> SingIn(BuildContext context) {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final double statusBarHeight = MediaQuery.of(context).padding.top;
  final double navigationBarHeight = MediaQuery.of(context).padding.bottom;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                var email = emailController.text;
                                var password = passwordController.text;
                                User? user = await _authService
                                    .signInWithEmailAndPassword(
                                        email, password);
                                if (user != null) {
                                  Navigator.pop(context);
                                  showCustomDialog(context,
                                      title: 'Sign In Successful',
                                      content: 'Enjoy this app',
                                      buttonText: 'OK');
                                } else {
                                  showCustomDialog(context,
                                      title: 'Sign In Failed',
                                      content:
                                          'Invalid email or password. Please try again.',
                                      buttonText: 'OK');
                                }
                              },
                              child: Text("Sign In"),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                var email = emailController.text;
                                var password = passwordController.text;
                                // Call registerWithEmailAndPassword method
                                User? user = await _authService
                                    .registerWithEmailAndPassword(
                                        email, password);
                                if (user != null) {
                                  Navigator.pop(context);
                                  showCustomDialog(context,
                                      title: 'Registration Successful',
                                      content: 'Enjoy this app',
                                      buttonText: 'OK');
                                } else {
                                  showCustomDialog(context,
                                      title: 'Registration fail',
                                      content: 'Try again later',
                                      buttonText: 'OK');
                                }
                              },
                              child: Text("Register"),
                            ),
                          ),
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
