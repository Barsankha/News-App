import 'dart:developer';

import 'package:channel_1/main/News/newspage/newsdetail/newsdetail.dart';
import 'package:channel_1/main/News/newspage/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NewsTile extends StatefulWidget {
  final String author;
  final String title;
  final String image;
  final String category;
  final String description;
  final String publish;
  final String url;
  const NewsTile(
      {super.key,
      required this.author,
      required this.title,
      required this.image,
      required this.category,
      required this.description,
      required this.publish,
      required this.url});

  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  InterstitialAd? interstitialAd;
  bool isad = false;
  @override
  void initState() {
    super.initState();
    loadinterstitialAd();
  }

  void loadinterstitialAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          interstitialAd = ad;
          isad = true;
        }, onAdFailedToLoad: (error) {
          log('interstital ad failed to load:$error', level: 100);
          isad = false;
        }));
  }

  void showInterstitialAd(Function onAdDimissiedCallback) {
    if (isad) {
      interstitialAd?.show();
      interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          loadinterstitialAd();
          onAdDimissiedCallback();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          onAdDimissiedCallback();
        },
      );
    } else {
      onAdDimissiedCallback();
    }
  }

  @override
  void dispose() {
    interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sreensize = MediaQuery.of(context).size;
    final width = sreensize.width;
    final isSmallScreen = width < 600;
    final titleSize = isSmallScreen ? 16.0 : 22.0;
    final categoryFontSize = isSmallScreen ? 12.0 : 14.0;
    final authorFontSize = isSmallScreen ? 10.0 : 12.0;
    final cardHeight = isSmallScreen ? 180.0 : 220.0;
    final padding = isSmallScreen ? 8.0 : 16.0;
    return GestureDetector(
        onTap: () {
          showInterstitialAd(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Newsdetail(
                          author: widget.author,
                          title: widget.title,
                          image: widget.image,
                          category: widget.category,
                          description: widget.description,
                          publish: widget.publish,
                          url: widget.url,
                        )));
          });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              ImageWidget(
                  imageUrl: widget.image, height: cardHeight, width: width),
              Container(
                height: cardHeight,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned.fill(
                  child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.category,
                          style: TextStyle(
                              fontSize: categoryFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        cleanText(widget.title),
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(widget.author,
                                style: TextStyle(
                                  fontSize: authorFontSize,
                                  color: Colors.white.withOpacity(0.9),
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ));
  }

  String cleanText(String text) {
    return text.replaceAll('_', ' ');
  }
}
//text.replaceAll('â', '’');