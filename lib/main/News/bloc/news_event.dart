import '../service/api_service.dart';

abstract class NewsEvent {}

class LoadNews extends NewsEvent {
  final NewsSource source;
  LoadNews(this.source);
}
