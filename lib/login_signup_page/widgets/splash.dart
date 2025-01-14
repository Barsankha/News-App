import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/splash.gif',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}
