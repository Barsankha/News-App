// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:channel_1/main/News/bloc/news_event.dart';
import 'package:channel_1/main/News/bloc/news_state.dart';
import '../service/api_service.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final ApiService apiService;
  NewsBloc(this.apiService) : super(NewsState()) {
    on<LoadNews>(_onLoadNews);
  }
  Future<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    if (event.source == NewsSource.wikimedia && state.wikimedia.isNotEmpty) {
      return;
    }
    if (event.source == NewsSource.currents && state.currents.isNotEmpty) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    try {
      final article1 = await apiService.fetchNews(NewsSource.currents);
      final article2 = await apiService.fetchNews(NewsSource.wikimedia);
      emit(state.copyWith(
        currents: article1,
        wikimedia: article2,
        isLoading: false,
        error: '',
        isReloadedWiKi: false,
        isReloadedcurr: false,
      ));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          error: e.toString(),
          isReloadedWiKi: event.source == NewsSource.wikimedia
              ? true
              : state.isReloadedWiKi,
          isReloadedcurr: event.source == NewsSource.currents
              ? true
              : state.isReloadedcurr));
    }
  }
}
