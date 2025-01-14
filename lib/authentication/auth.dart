// ignore_for_file: use_build_context_synchronously
import 'package:channel_1/authentication/database.dart';
import 'package:channel_1/login_signup_page/widgets/snackbar.dart';
import 'package:channel_1/main/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Get the current user
  Future<User?> getCurrentUser() async {
    return auth.currentUser; // No need for 'await' here
  }

  // Sign in with Google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        // The user canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential result = await auth.signInWithCredential(credential);
      User? userDetails = result.user;

      if (userDetails != null) {
        Map<String, dynamic> userInfoMap = {
          "email": userDetails.email,
          "name": userDetails.displayName,
          "imgUrl": userDetails.photoURL,
          "id": userDetails.uid,
        };

        await DatabaseMethods().addUser(userDetails.uid, userInfoMap);
        // Navigate to Home screen if needed
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Homescreen()));
      }
    } catch (e) {
      showSnackbar(
          context, 'Error during Google sign-in: $e', Colors.redAccent);
    }
  }

  // Sign up with Google
  Future<User?> signUpWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return null; // The user canceled the sign-in
    }
    try {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      User? userData = userCredential.user;

      if (userData != null) {
        Map<String, dynamic> userInfoMap = {
          "email": userData.email,
          "name": userData.displayName,
          "imgUrl": userData.photoURL,
          "id": userData.uid,
        };
        await DatabaseMethods().addUser(userData.uid, userInfoMap);
        return userData;
      }
    } catch (e) {
      showSnackbar(
          context, 'Error during Google sign-up: $e', Colors.redAccent);
    }
    return null; // Return null if sign-in fails
  }

  // Sign up with email and password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the newly created user
      User? user = userCredential.user;

      if (user != null) {
        Map<String, dynamic> userInfoMap = {
          "email": user.email,
          "name": user.displayName ?? '', // Handle null display name
          "imgUrl": user.photoURL ?? '', // Handle null photo URL
          "id": user.uid,
        };

        await DatabaseMethods().addUser(user.uid, userInfoMap);

        // Send email verification
        await user.sendEmailVerification();
        return user; // Return the user
      }
    } on FirebaseAuthException catch (e) {
      throw Exception("Error during sign-up: $e");
    }
    return null; // Return null if sign-up fails
  }

  // Check email verification
  Future<void> checkEmailVerification(BuildContext context, User? user) async {
    if (user != null) {
      await user.reload(); // Reload the user to get updated info
      user = auth.currentUser; // Refresh the current user

      if (user != null && user.emailVerified) {
        // Email is verified, navigate to Home page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Homescreen()),
        );
      } else {
        showSnackbar(context, 'Please verify your email to continue.',
            Colors.orangeAccent);
      }
    }
  }
}
