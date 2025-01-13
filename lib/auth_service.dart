import 'dart:developer';
import 'package:firebase/pages/home_page.dart';
import 'package:firebase/pages/login_page.dart';
import 'package:firebase/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> loginWithGoogle(BuildContext context) async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      final userCredential = await _auth.signInWithCredential(cred);
      _navigateToHome(context);
      return userCredential;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _navigateToHome(context);
      return cred.user;
    } catch (e) {
      log("Error during signup: $e");
    }
    return null;
  }

  Future<UserCredential?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      // Sign out any existing sessions first to avoid issues with expired credentials
      await FirebaseAuth.instance.signOut();

      // Proceed with login
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      log("Firebase error: ${e.code}: ${e.message}");
      if (e.code == 'invalid-credential') {
        log('The credentials provided are incorrect or malformed.');
      }
      return null;
    } catch (e) {
      log("Unknown error: $e");
      return null;
    }
  }



  void navigateToSignup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupPage()),
    );
  }

  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Error during signout: $e");
    }
  }
}
