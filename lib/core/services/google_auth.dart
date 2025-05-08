import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_doctor_buddy/core/const_colors.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return null;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print("Google sign-in error: $e");
      return null;
    }
  }

  Future<UserCredential?> anonymousLogin() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      log("Signed in with temporary account. $userCredential");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          log("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          log("Unknown error.");
      }
    }
  }

  Future<GoogleSignInAccount?> signOut() async {
    try {
      await _auth.signOut();
      var res = await _googleSignIn.signOut();
      if (_auth.currentUser == null) {
        Get.snackbar("Succes", "Log Out successfully", colorText: green);
        return res;
      }
      return null;
    } catch (e) {
      Get.snackbar("Failed", "Could not Log Out", colorText: red);
      return null;
    }
  }
}
