import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final bool isdark;
  final VoidCallback? ontap;
  const ProfileListItem({
    super.key,
    required this.icon,
    required this.text,
    this.hasNavigation = true,
    required this.isdark,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: isdark ? Colors.black54 : Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 25,
            color: isdark ? Colors.white : Colors.black,
          ),
          const SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: isdark ? Colors.white : Colors.black,
            ),
          ),
          const Spacer(),
          if (hasNavigation)
            IconButton(
              icon: Icon(
                Icons.chevron_right,
                size: 25,
                color: isdark ? Colors.white : Colors.black,
              ),
              onPressed: ontap,
            ),
        ],
      ),
    );
  }
}
