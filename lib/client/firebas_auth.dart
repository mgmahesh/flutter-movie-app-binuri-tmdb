// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app_example/models/application_user.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user {
    // signInWithEmailAndPassword('mgmaheshnew@gmail.com', 'pfU3LGjq5vAxKtF');
    return _auth.authStateChanges();
  }

  Future<User?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<User?> editUser(
      {required String email,
      required String password,
      required String displayName,
      required String photoURL}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;

      await user?.updateProfile(displayName: displayName, photoURL: photoURL);

      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
