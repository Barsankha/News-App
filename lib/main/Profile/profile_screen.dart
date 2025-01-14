import 'package:channel_1/login_signup_page/pages/login_pages.dart';
import 'package:channel_1/main/Profile/profileConstant/profile_class.dart';
import 'package:channel_1/main/Profile/profile_page_section/about_page.dart';
import 'package:channel_1/main/cubit/theme_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    bool isdark = context.watch<ThemeCubit>().state;
    return Scaffold(
      backgroundColor: isdark ? Colors.black : Colors.white,
      body: Column(
        children: <Widget>[
          const SizedBox(height: 40),
          _buildHeader(context),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: <Widget>[
                ProfileListItem(
                  icon: Icons.help_outline_outlined,
                  text: 'Help & Support',
                  isdark: isdark,
                ),
                ProfileListItem(
                  icon: Icons.info_outline_rounded,
                  text: 'About',
                  isdark: isdark,
                  ontap: () => About_page,
                ),
                ProfileListItem(
                  icon: Icons.share,
                  text: 'Invite with Friends',
                  isdark: isdark,
                  ontap: sharePressed,
                ),
                ProfileListItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  hasNavigation: false,
                  isdark: isdark,
                  ontap: _logout,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void sharePressed() {
    String mesage = 'Check out this app!';
    Share.share(mesage);
  }

  // ignore: non_constant_identifier_names
  void About_page() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AboutPage()));
  }

  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => WelcomePage()));
      // ignore: empty_catches
    } catch (e) {}
  }

  Widget _buildHeader(BuildContext context) {
    String emailid = user?.email ?? 'User@gmail.com';
    String username = user?.displayName ?? 'User';
    bool isdark = context.watch<ThemeCubit>().state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/news2.jpg'),
            ),
            const SizedBox(height: 10),
            Text(
              username,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isdark ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 5),
            Text(
              emailid,
              style: TextStyle(
                  color: isdark ? Colors.blueGrey[200] : Colors.black),
            ),
          ],
        ),
        IconButton(
          icon: Icon(isdark ? Icons.light_mode : Icons.dark_mode),
          onPressed: () => context.read<ThemeCubit>().toggletheme(),
        ),
      ],
    );
  }
}
