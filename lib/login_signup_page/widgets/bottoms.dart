import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Future<void> Function()? onTap;
  final String text;
  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(); // Call the async function
        }
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.blueGrey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
    );
  }
}

class MyButtonAgree extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButtonAgree({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 71, 233, 133),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
