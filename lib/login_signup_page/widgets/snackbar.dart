import 'package:flutter/material.dart';

showSnackbar(BuildContext context, String text, Color color) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      content: Text(
        text,
        style: const TextStyle(fontSize: 20.0),
      )));
}
