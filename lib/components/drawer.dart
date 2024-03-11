import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_example/client/firebas_auth.dart';
import 'package:movie_app_example/screens/Drawer/edit_user.dart';
import 'package:movie_app_example/screens/Drawer/my_profile.dart';
import 'package:movie_app_example/screens/Drawer/singin_user.dart';
import 'package:provider/provider.dart';

import '../screens/Drawer/saved_movies.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              accountName: user != null
                  ? Text(user.displayName ?? "Please Sing In")
                  : Text("Please Sing In"),
              accountEmail: user != null ? Text(user.email ?? "") : Text(""),
              currentAccountPictureSize: Size.square(50),
              currentAccountPicture: user != null && user.photoURL != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(user.photoURL!),
                    )
                  : const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 165, 255, 137),
                      child: Text(
                        "A",
                        style: TextStyle(fontSize: 30.0, color: Colors.blue),
                      ),
                    ),
            ),
          ),
          user != null
              ? ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text(' My Profile '),
                  onTap: () {
                    Navigator.pop(context);
                    MyProfile(context);
                  },
                )
              : const SizedBox(),
          user != null
              ? ListTile(
                  leading: const Icon(Icons.video_label),
                  title: const Text(' Saved Movies '),
                  onTap: () {
                    Navigator.pop(context);
                    SavedMovies(context);
                  },
                )
              : const SizedBox(),
          user != null
              ? ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text(' Edit Profile '),
                  onTap: () {
                    Navigator.pop(context);
                    EditUser(context);
                  },
                )
              : const SizedBox(),
          user != null
              ? ListTile(
                  leading: const Icon(Icons.supervised_user_circle),
                  title: const Text(' Log Out '),
                  onTap: () {
                    Navigator.pop(context);
                    FirebaseAuthService().signOut();
                  },
                )
              : ListTile(
                  leading: const Icon(Icons.supervised_user_circle),
                  title: const Text(' Log In '),
                  onTap: () {
                    Navigator.pop(context);
                    SingIn(context);
                  },
                ),
        ],
      ),
    );
  }
}
