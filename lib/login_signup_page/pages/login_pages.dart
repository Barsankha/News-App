// ignore_for_file: use_build_context_synchronously

import 'package:channel_1/login_signup_page/pages/signup_pages.dart';
import 'package:channel_1/main/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../authentication/auth.dart';
import '../widgets/backgroung_imagewidet.dart';
import '../widgets/snackbar.dart';

// ignore: must_be_immutable
class WelcomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // text editing controllers
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final AuthMethods authMethods = AuthMethods();
  Future<void> signInWithGoogle() async {
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      await authMethods.signInWithGoogle(context);
      Navigator.pop(context); // Close any loading dialogs if applicable
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homescreen()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        case 'operation-not-allowed':
          message = 'Google sign-in is not enabled.';
          break;
        default:
          message = 'An undefined error occurred.';
      }
      showSnackbar(context, message, Colors.red);
    } catch (e) {
      // Handle any other errors
      showSnackbar(context, 'An error occurred: $e', Colors.red);
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

// Login user
  Future<void> loginUser() async {
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text
            .trim(), // Trim input to avoid whitespace issues
        password: passwordController.text.trim(),
      );
      //Navigator.pop(context); // Close any loading dialogs if applicable
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Homescreen()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        default:
          message = 'An undefined error occurred.';
      }
      showSnackbar(context, message, Colors.red);
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SignUpScreen(
          isLoading: isLoading,
          formKey: _formKey,
          emailController: emailController,
          passwordController: passwordController,
          ontap: loginUser,
          ongoogle: signInWithGoogle,
          title: 'Hi Welcome back!',
          bottomtitle: 'Dont have an account?',
          bottomtitle2: 'Sign Up',
          onpage: onPage,
          onlook: onLook,
        ));
  }

  void onPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Homescreen()));
  }

  onLook() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Signup()));
  }
}
