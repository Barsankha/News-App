import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  final String text;
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $text';
        }
        return null;
      },
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
      decoration: InputDecoration(
        prefixIcon: icon,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent, //Colors.grey.shade400,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 3),
        ),
        fillColor: Colors.transparent, // Colors.grey.shade200,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Colors.black, fontSize: 22 // Colors.grey[500],
            ),
      ),
    );
  }
}

class MyPasswordTextField extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  const MyPasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<MyPasswordTextField> createState() => _MyPasswordTextFieldState();
}

class _MyPasswordTextFieldState extends State<MyPasswordTextField> {
  bool obscuretext = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Password';
        }
        return null;
      },
      controller: widget.controller,
      obscureText: obscuretext,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.lock,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscuretext = !obscuretext;
              });
            },
            icon: Icon(
              obscuretext ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
          ),
          fillColor: Colors.transparent, // Colors.grey.shade200,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black, fontSize: 22)),
    );
  }
}
