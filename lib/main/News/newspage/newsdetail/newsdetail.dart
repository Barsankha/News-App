import 'package:channel_1/login_signup_page/widgets/snackbar.dart';
import 'package:channel_1/main/News/newspage/newsdetail/news_details_appbar.dart';
import 'package:channel_1/main/News/newspage/newsdetail/newsdetail_body.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Newsdetail extends StatelessWidget {
  final String author;
  final String title;
  final String image;
  final String category;
  final String description;
  final String publish;
  final String url;
  const Newsdetail({
    super.key,
    required this.author,
    required this.title,
    required this.image,
    required this.category,
    required this.description,
    required this.publish,
    required this.url,
  });
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          NewsDetailsAppBar(
            author: author,
            title: title,
            image: image,
            category: category,
            publish: publish,
          ),
          SliverToBoxAdapter(
            child: NewsDetailsBody(
              author: author,
              title: title,
              description: description,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> launchArticleUrl(BuildContext context, String? url) async {
    if (url != null && url.isNotEmpty) {
      try {
        final Uri uri = Uri.parse(url);
        if (await launchUrl(uri)) {
        } else {
          throw Exception('cound not launch Url');
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        showSnackbar(context, 'Error launching URL', Colors.red[200]!);
      }
    } else {
      showSnackbar(context, 'Invalid URl', Colors.red[200]!);
    }
  }
}
