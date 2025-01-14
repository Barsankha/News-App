import 'package:channel_1/login_signup_page/widgets/splash.dart';
import 'package:channel_1/main/News/bloc/news_bloc.dart';
import 'package:channel_1/main/News/bloc/news_event.dart';
import 'package:channel_1/main/News/bloc/news_state.dart';
import 'package:channel_1/main/News/newspage/widgets/Newsview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/api_service.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(LoadNews(NewsSource.wikimedia));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CustomLoadingWidget(),
          );
        } else if (state.error.isNotEmpty) {
          return Center(child: Text(state.error));
        } else {
          return SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: Newsview(
                  len: state.wikimedia.length,
                  articles: state.wikimedia,
                  xy: Axis.vertical,
                  autoplay: false,
                )),
          );
        }
      }),
    );
  }
}
