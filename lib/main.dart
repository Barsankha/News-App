import 'package:channel_1/main/News/bloc/news_bloc.dart';
import 'package:channel_1/main/News/service/api_service.dart';
import 'package:channel_1/main/cubit/theme_cubit.dart';
import 'package:channel_1/main/dictionary/bloc/search_bloc.dart';
import 'package:channel_1/main/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_signup_page/pages/login_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsBloc(ApiService())),
        BlocProvider(create: (context) => SearchBloc())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  bool haspage = false;
  bool islogin = false;
  checkLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          islogin = true;
        });
      }
    });
  }

  Future<void> checkfirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasSeen = prefs.getBool('haspage');
    if (hasSeen == null || hasSeen == false) {
      setState(() {
        haspage = false;
      });
      await prefs.setBool('haspage', true);
    } else {
      setState(() {
        haspage = true;
      });
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(false),
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isdark) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: isdark ? ThemeData.dark() : ThemeData.light(),
              home:!haspage
                   ? WelcomePage()
                   : islogin
                       ? const Homescreen()
                       : WelcomePage(),
              );
        },
      ),
    );
  }
}
