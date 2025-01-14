import 'package:flutter/material.dart';

class Customappbar extends StatelessWidget implements PreferredSizeWidget {
  const Customappbar({super.key});

  @override
  Widget build(BuildContext context) {
    // double radius = 35;
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 5,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
        ),
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0))),
      toolbarHeight: kBottomNavigationBarHeight,
      title: Row(
        children: [
          Image.asset(
            'assets/logo.png',
            height: 40,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10.0,
          ),
          const Text(
            'hannel',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
        ],
      ),
    );
  }

  @override
  // ignore: recursive_getters
  Size get preferredSize => const Size.fromHeight(kBottomNavigationBarHeight);
}
