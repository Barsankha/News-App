import 'dart:io';
import 'dart:developer';
import 'package:channel_1/main/News/newspage/widgets/image.dart';
import 'package:channel_1/main/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class NewsDetailsAppBar extends StatefulWidget {
  final String image;
  final String author;
  final String publish;
  final String title;
  final String category;
  const NewsDetailsAppBar(
      {super.key,
      required this.image,
      required this.author,
      required this.publish,
      required this.title,
      required this.category});

  @override
  State<NewsDetailsAppBar> createState() => _NewsDetailsAppBarState();
}

class _NewsDetailsAppBarState extends State<NewsDetailsAppBar> {
  @override
  Widget build(BuildContext context) {
    final sreensize = MediaQuery.of(context).size;
    final height = sreensize.height;
    final width = sreensize.width;
    final isSmallScreen = width < 600;
    final titleSize = isSmallScreen ? 28.0 : 38.0;
    final categoryFontSize = isSmallScreen ? 14.0 : 18.0;
    final authorFontSize = isSmallScreen ? 14.0 : 18.0;
    bool isdark = context.watch<ThemeCubit>().state;
    return SliverAppBar(
      expandedHeight: height * 0.4,
      leading: Padding(
        padding: const EdgeInsets.only(left: 2.0),
        child: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 40,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      leadingWidth: 40,
      actions: <Widget>[
        // Icon(Icons.bookmark_add_outlined),
        // SizedBox(width: 6.0),
        IconButton(
          icon: const Icon(
            Icons.share,
            size: 30,
          ),
          onPressed: () => sharenews(widget.title, widget.image),
        ),
        const SizedBox(width: 18.0),
      ],
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: ImageWidget(
                  imageUrl: widget.image, height: height, width: width),
            ),
            Positioned(
              bottom: 50,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.category,
                        style: TextStyle(
                            fontSize: categoryFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    width: sreensize.width * 0.9,
                    child: Text(
                      cleanText(widget.title),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: titleSize,
                      ),
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '${widget.author} • ${widget.publish}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: authorFontSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground,
        ],
      ),
      pinned: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: SizedBox(
          height: 30,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isdark ? Colors.transparent : Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(36.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String cleanText(String text) {
    return text.replaceAll('_', ' ');
  }

  void sharenews(String title, String imageurl) async {
    try {
      final uri = Uri.parse(imageurl);
      final response = await http.get(uri);
      final temdir = await getTemporaryDirectory();
      final filepath = File('${temdir.path}/shared_image.jpg');
      final file = File(filepath as String);
      await file.writeAsBytes(response.bodyBytes);
      final XFile xFile = XFile(file.path);
      await Share.shareXFiles([xFile],
          text: '$title\n\nRead more at: Channel', subject: 'Trending news');
    } catch (e, stackTrace) {
      log('An error occurred: $e',
          level: 100, error: e, stackTrace: stackTrace);
    }
  }
}
//'â', '’'