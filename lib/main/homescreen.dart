import 'package:channel_1/main/News/Explore/explore.dart';
import 'package:channel_1/main/Profile/profile_screen.dart';
import 'package:channel_1/main/dictionary/dictionary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'News/newspage/news_page.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selctedindex = 0;
  List<Widget> _getscreens() {
    return [
      const NewsScreen(),
      const ExplorePage(),
      SearchPage(),
      const ProfileScreen(),
    ];
  }

  void onitemtapp(int index) {
    setState(() {
      selctedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenweight = MediaQuery.of(context).size.width;
    List<Widget> screen = _getscreens();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    // bool isdark = context.watch<ThemeCubit>().state;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: screen[selctedindex],
          ),
          Positioned(
            right: screenWidth * 0.08,
            top: screenHeight * 0.9,
            child: Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: SizedBox(
                  width: screenweight * 0.85,
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.home), label: 'Home'),
                      // BottomNavigationBarItem(
                      //     icon: Icon(Icons.search), label: 'Search'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.language), label: 'Explore'),
                      BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.textformat),
                          label: 'Dictionary'),
                      BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.profile_circled),
                          label: 'Profile'),
                    ],
                    currentIndex: selctedindex,
                    selectedItemColor: Colors.redAccent[200],
                    unselectedItemColor: Colors.black,
                    onTap: onitemtapp,
                    type: BottomNavigationBarType.fixed,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//left: 10.55886,
//top: 729.910910,