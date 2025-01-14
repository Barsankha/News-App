abstract class NewsArticle {
  String get title;
  String get url;
  String get description;
  String? get imagrUrl;
}

class ArticleInfo implements NewsArticle {
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String url;
  final String author;
  final String? image; // Use String? to accommodate null values
  final List<String> category;
  final DateTime published;
  final String thumbnail;

  ArticleInfo({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.author,
    this.image,
    required this.category,
    required this.published,
    required this.thumbnail,
  });

  factory ArticleInfo.fromJson(Map<String, dynamic> json) {
    return ArticleInfo(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'No Title',
      description: json['description'] as String? ?? 'No description',
      url: json['url'] as String? ?? '',
      author: json['author'] as String? ?? 'Unknown',
      image: (json['image'] != null && json['image'] != "None")
          ? json['image'] as String
          : null,
      category: List<String>.from(json['category'] ?? []),
      published: DateTime.tryParse(json['published'] as String? ?? '') ??
          DateTime.now(),
      thumbnail: json['thumbnail']?['source'] as String? ?? '',
    );
  }

  @override
  String? get imagrUrl => image;
}

class WikimediaFeatured {
  final MostRead mostRead;
  final ImageData image;
  final List<ReadArticle> news;

  WikimediaFeatured({
    required this.mostRead,
    required this.image,
    required this.news,
  });

  factory WikimediaFeatured.fromJson(Map<String, dynamic> json) {
    return WikimediaFeatured(
      mostRead: MostRead.fromJson(json['mostread']),
      image: ImageData.fromJson(json['image']),
      news: (json['news'] as List<dynamic>)
          .map((article) =>
              ReadArticle.fromJson(article as Map<String, dynamic>))
          .toList(),
    );
  }
}

class MostRead {
  final List<ReadArticle> articles;

  MostRead({required this.articles});

  factory MostRead.fromJson(Map<String, dynamic> json) {
    return MostRead(
      articles: (json['articles'] as List<dynamic>? ?? [])
          .map((article) =>
              ReadArticle.fromJson(article as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ReadArticle implements NewsArticle {
  @override
  final String title;
  @override
  final String description;
  final String pageurl;
  final String thumbnailUrl;

  ReadArticle({
    required this.title,
    required this.description,
    required this.pageurl,
    required this.thumbnailUrl,
  });

  factory ReadArticle.fromJson(Map<String, dynamic> json) {
    return ReadArticle(
      title: _getTitle(json),
      description: _getdescription(json),
      pageurl: _getPageUrl(json),
      thumbnailUrl: _getThumbnailUrl(json),
    );
  }

  static String _getTitle(Map<String, dynamic> json) {
    String title = 'No Title';
    String des = "No description";
    if (json.containsKey('articles') && json['articles'] is List) {
      final articles = json['articles'] as List;
      title = articles.isNotEmpty ? articles[0]['title'] ?? title : title;
      des = articles.isNotEmpty ? articles[0]['description'] ?? des : des;
      final titles = '$title: $des';
      return titles;
    } else if (json.containsKey('links')) {
      final links =
          (json['links'] as List).isNotEmpty ? json['links'][0] : null;
      // print(links);
      final titles =
          links['titles'] != null ? links['titles']['normalized'] : '';
      final title = '${links['title']} : ${links['description'] ?? titles}';
      return title;
    }
    return title;
  }

  static String _getdescription(Map<String, dynamic> json) {
    String des = "No description";
    if (json.containsKey('articles')) {
      final articles =
          (json['articles'] as List).isNotEmpty ? json['articles'][0] : null;
      final des = articles['extract'] as String? ?? 'No description';
      return des;
    } else if (json.containsKey('links')) {
      final links =
          (json['links'] as List).isNotEmpty ? json['links'][0] : null;
      final des = links['extract'] as String? ?? 'No Description';
      return des;
    }
    return 'No Title';
  }

  static String _getPageUrl(Map<String, dynamic> json) {
    // Adjusting the method to accommodate different possible structures
    final contentUrls = json['content_urls'];
    if (contentUrls != null && contentUrls['desktop'] != null) {
      return contentUrls['desktop']['page'] as String? ?? '';
    }
    return '';
  }

  static String _getThumbnailUrl(Map<String, dynamic> json) {
    if (json.containsKey('articles')) {
      final articles =
          (json['articles'] as List).isNotEmpty ? json['articles'][0] : null;
      final thumbnail =
          articles['thumbnail'] != null ? articles['thumbnail']['source'] : '';
      return thumbnail;
    } else if (json.containsKey('links')) {
      final links =
          (json['links'] as List).isNotEmpty ? json['links'][0] : null;
      final thumbnail =
          links['thumbnail'] != null ? links['thumbnail']['source'] : '';
      return thumbnail;
    }
    return '';
  }

  @override
  String? get imagrUrl => thumbnailUrl;

  @override
  String get url => pageurl;
}

class ImageData {
  final String title;
  final String imageUrl;
  final String filePage;

  ImageData({
    required this.title,
    required this.imageUrl,
    required this.filePage,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      title: json['title'] as String? ?? '',
      imageUrl: json['image']['source'] as String? ?? '',
      filePage: json['file_page'] as String? ?? '',
    );
  }
}
