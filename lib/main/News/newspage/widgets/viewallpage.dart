import 'dart:ui';
import 'package:channel_1/main/News/newspage/widgets/Newsview.dart';
import 'package:channel_1/main/News/service/news_model.dart';
import 'package:flutter/material.dart';

class Viewallpage extends StatelessWidget {
  final List<NewsArticle> articles;
  final int len;
  const Viewallpage({super.key, required this.articles, required this.len});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white.withAlpha(400),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Newsview(
          len: len,
          articles: articles,
          xy: Axis.vertical,
          autoplay: false,
        ),
      )),
    );
  }
}
