// ignore_for_file: use_build_context_synchronously
import 'package:channel_1/login_signup_page/pages/login_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../authentication/auth.dart';
import '../../main/homescreen.dart';
import '../widgets/backgroung_imagewidet.dart';
import '../widgets/snackbar.dart';

// ignore: must_be_immutable
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // text editing controllers
  TextEditingController namecontroller = TextEditingController();

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  //google sign up
  Future<void> signUpWithGoogle() async {
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      User? user = await AuthMethods()
          .signUpWithGoogle(context); // Call the sign-up method
      if (user != null) {
        // Successful sign-up, navigate to Home
        showSnackbar(context, 'Sign Up Successfully', Colors.greenAccent);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homescreen()),
        );
      } else {
        // Handle case where user is null
        showSnackbar(
            context, 'Sign-up failed. Please try again.', Colors.redAccent);
      }
    } catch (e) {
      // Handle errors
      showSnackbar(context, 'Error during sign-up: $e', Colors.redAccent);
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

// Register user
  Future<void> signupUser() async {
    setState(() {
      isLoading = true;
    });

    // Check if the fields are not empty
    if (namecontroller.text.isNotEmpty && emailcontroller.text.isNotEmpty) {
      try {
        User? user = await AuthMethods()
            .signUpWithEmail(emailcontroller.text, passwordcontroller.text);
        if (user != null) {
          showSnackbar(
              context,
              'Verification email sent. Please check your inbox',
              Colors.deepOrangeAccent);

          // Check email verification
          await AuthMethods().checkEmailVerification(context, user);

          // Optionally, you might want  navigate to another page here
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Homescreen()));
        } else {
          showSnackbar(
              context, 'Sign-up failed. Please try again.', Colors.redAccent);
        }
      } on FirebaseAuthException catch (e) {
        // Improved error handling
        String errorMessage = '';
        if (e.code == 'weak-password') {
          errorMessage = 'Password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Account already exists.';
        } else {
          errorMessage = 'An unexpected error occurred. Please try again.';
        }
        showSnackbar(context, errorMessage, Colors.redAccent);
      } finally {
        setState(() {
          isLoading = false; // Stop loading
        });
      }
    } else {
      // Show a message if fields are empty
      showSnackbar(context, 'Please fill in all fields.', Colors.orangeAccent);
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  //dispose
  @override
  void dispose() {
    emailcontroller.dispose();
    namecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SignUpScreen(
          isLoading: isLoading,
          formKey: _formKey,
          emailController: emailcontroller,
          passwordController: passwordcontroller,
          nameController: namecontroller,
          ontap: signupUser,
          ongoogle: signUpWithGoogle,
          title: 'Sign Up',
          bottomtitle: 'Already have an account',
          bottomtitle2: 'log in',
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
        context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }
}
