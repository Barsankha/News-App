import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final Future<void> Function()? onPressed;
  const SquareTile(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 40,
            ),
            const SizedBox(width: 20),
            Text(title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54))
          ],
        ),
      ),
    );
  }
}
