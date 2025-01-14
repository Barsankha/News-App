// ignore_for_file: file_names

import 'dart:async';
import 'dart:developer';
import 'package:channel_1/main/News/newspage/widgets/news_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../service/news_model.dart';

class Newsview extends StatefulWidget {
  final int len;
  final List<dynamic> articles;
  final Axis xy;
  final bool autoplay;
  const Newsview(
      {super.key,
      required this.len,
      required this.articles,
      required this.xy,
      required this.autoplay});

  @override
  State<Newsview> createState() => _NewsviewState();
}

class _NewsviewState extends State<Newsview> {
  int currentindex = 0;
  Timer? autoplayTimer;
  late BannerAd _bannerAd;
  bool isad = false;
  ScrollController scrollController = ScrollController();
  late List<dynamic> displayarticles;
  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-3940256099942544/9214589741',
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isad = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            log('ad failed to load', level: 100);
          },
        ),
        request: const AdRequest())
      ..load();
    displayarticles = widget.articles + widget.articles;
    scrollController = ScrollController(initialScrollOffset: 0);
    if (widget.xy == Axis.horizontal || widget.autoplay == true) {
      autoplayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (scrollController.hasClients) {
          double nextOffset =
              scrollController.offset + MediaQuery.of(context).size.width * 1;

          if (nextOffset >= scrollController.position.maxScrollExtent) {
            scrollController.jumpTo(0);
          } else {
            scrollController.animateTo(nextOffset,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    autoplayTimer?.cancel();
    scrollController.dispose();
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double paddingBottom = MediaQuery.of(context).size.height * 0.4; //16
    //final displayarticles = widget.articles.take(widget.len).toList();
    return SizedBox(
      height: widget.autoplay ? paddingBottom / 1.76 : null,
      child: ListView.builder(
          controller: scrollController,
          scrollDirection: widget.xy,
          shrinkWrap: true,
          physics: widget.autoplay
              ? const ScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          itemCount: displayarticles.length,
          itemBuilder: (context, index) {
            if (index == 3 && isad) {
              return SizedBox(
                height: _bannerAd.size.height.toDouble(),
                width: _bannerAd.size.width.toDouble(),
                child: AdWidget(ad: _bannerAd),
              );
            }
            final article = displayarticles[index % widget.len];
            String publisheddate = '';
            String authorA = '';
            String categoryA = '';
            String titleA = '';
            String descriptionA = '';
            String urlToImageA = '';
            String urlA = '';
            if (article is ArticleInfo) {
              urlToImageA = article.imagrUrl.toString();
              titleA = article.title.toString();
              descriptionA = article.description.toString();
              publisheddate = article.published.toString();
              authorA = article.author.toString();
              categoryA = article.category.toString();
              urlA = article.url.toString();
            } else {
              urlToImageA = article.thumbnailUrl.toString();
              titleA = article.title.toString();
              descriptionA = article.description.toString();
              publisheddate = DateTime.now().toString();
              authorA = 'Unknown Author';
              categoryA = 'General';
              urlA = 'posible';
            }
            return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: widget.autoplay
                      ? paddingBottom / 256
                      : paddingBottom / 32,
                  horizontal: widget.autoplay
                      ? paddingBottom / 32
                      : paddingBottom / 128,
                ),
                child: SizedBox(
                  width: widget.autoplay
                      ? MediaQuery.of(context).size.width * 0.80
                      : 0,
                  child: NewsTile(
                    image: urlToImageA,
                    title: titleA,
                    description: descriptionA,
                    url: urlA,
                    publish: publisheddate,
                    author: authorA,
                    category: categoryA,
                  ),
                ));
          }),
    );
  }
}
