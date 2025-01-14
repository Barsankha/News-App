// News States

import '../service/news_model.dart';

class NewsState {
  final List<NewsArticle>
      wikimedia; // For Wikimedia news // For current latest news
  final List<NewsArticle>
      currents; // For Wikimedia news // For current latest news
  final bool isLoading;
  final String error;
  final bool isReloadedWiKi;
  final bool isReloadedcurr;

  NewsState({
    this.wikimedia = const [],
    this.currents = const [],
    this.isLoading = false,
    this.error = '',
    this.isReloadedWiKi = false,
    this.isReloadedcurr = false,
  });

  NewsState copyWith({
    List<NewsArticle>? wikimedia,
    List<NewsArticle>? currents,
    bool? isLoading,
    String? error,
    bool? isReloadedWiKi,
    bool? isReloadedcurr,
  }) {
    return NewsState(
      wikimedia: wikimedia ?? this.wikimedia,
      currents: currents ?? this.currents,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isReloadedWiKi: isReloadedWiKi ?? this.isReloadedWiKi,
      isReloadedcurr: isReloadedcurr ?? this.isReloadedcurr,
    );
  }
}
