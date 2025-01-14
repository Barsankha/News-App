import 'package:channel_1/main/News/bloc/news_state.dart';
import 'package:channel_1/main/News/newspage/widgets/Newsview.dart';
import 'package:channel_1/main/News/newspage/widgets/viewallpage.dart';
import 'package:channel_1/main/News/service/news_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../login_signup_page/widgets/splash.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_event.dart';
import '../service/api_service.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(LoadNews(NewsSource.wikimedia));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const Customappbar(),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CustomLoadingWidget());
          } else if (state.error.isNotEmpty) {
            return Center(
              child: Text(state.error),
            );
          } else {
            final trendingarticle = state.currents.map((article) {
              if (article is ArticleInfo) {
                return ArticleInfo(
                  id: article.id,
                  title: article.title,
                  description: article.description,
                  url: article.url,
                  author: article.author,
                  category: article.category,
                  published: article.published,
                  thumbnail: article.thumbnail,
                );
              } else {
                return ArticleInfo(
                    id: '',
                    title: article.title,
                    description: article.description,
                    url: article.url,
                    author: 'Unknown',
                    category: [],
                    published: DateTime.now(),
                    thumbnail: '');
              }
            }).toList();
            final trendingnews = trendingarticle.take(7).toList();
            final recommendedarticle = state.currents;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Latest News",
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Newsview(
                      len: 7,
                      articles: trendingnews,
                      xy: Axis.horizontal,
                      autoplay: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Recommended",
                            style: Theme.of(context).textTheme.titleMedium),
                        TextButton(
                            onPressed: () {
                              navigateToViewAllPage(
                                  context, recommendedarticle);
                            },
                            child: const Text(
                              "view all",
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Newsview(
                      len: state.currents.length,
                      articles: recommendedarticle,
                      xy: Axis.vertical,
                      autoplay: false,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void navigateToViewAllPage(BuildContext context, List<NewsArticle> articles) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Viewallpage(
          articles: articles,
          len: articles.length,
        ),
      ),
    );
  }
}
