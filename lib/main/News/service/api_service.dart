import 'dart:convert';
import 'package:channel_1/main/News/service/news_model.dart';
import 'package:http/http.dart' as http;

enum NewsSource { wikimedia, currents }

class ApiService {
  final String currentsApiKey =
      'your api key';
  final String wikimediaBaseUrl = 'https://en.wikinews.org/w/api.php';
  final String currentsBaseUrl =
      'https://api.currentsapi.services/v1/latest-news';

  // Method to fetch news based on the source
  Future<List<NewsArticle>> fetchNews(NewsSource source) async {
    print(source);
    switch (source) {
      case NewsSource.wikimedia:
        return await _fetchFeaturedArticles(DateTime.now());
      case NewsSource.currents:
        return await _fetchFeaturedArticles(DateTime.now());
      default:
        throw Exception('Invalid news source');
    }
  }

  // Function to fetch featured articles from Wikimedia
  Future<List<ReadArticle>> _fetchFeaturedArticles(DateTime date) async {
    final formattedDate =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    final response = await http.get(Uri.parse(
        'https://api.wikimedia.org/feed/v1/wikipedia/en/featured/$formattedDate'));
    //print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      List<dynamic> articleJson;
      List<dynamic> mostread;
      mostread = jsonResponse['mostread']['articles'] as List<dynamic>;
      articleJson = jsonResponse['news'] as List<dynamic>;
      return articleJson.map((article) {
        return ReadArticle.fromJson(article);
      }).toList();
    } else {
      throw Exception(
          'Failed to load featured articles: ${response.statusCode}');
    }
  }

  // Fetch current latest news
  Future<List<ArticleInfo>> _fetchCurrentsNews() async {
    final response = await http.get(Uri.parse(
      '$currentsBaseUrl?language=en&apiKey=$currentsApiKey',
    ));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      print(jsonResponse);

      if (jsonResponse['news'] != null && jsonResponse['news'] is List) {
        return (jsonResponse['news'] as List)
            .map((item) => ArticleInfo.fromJson(item))
            .toList();
      } else {
        throw Exception('Latest news data not found in the response');
      }
    } else {
      throw Exception('Failed to load current news: ${response.statusCode}');
    }
  }
}
