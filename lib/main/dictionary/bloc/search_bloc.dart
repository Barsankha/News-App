// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:channel_1/main/dictionary/bloc/search_state.dart';
import 'package:channel_1/main/dictionary/service/services.dart';

part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<SearchWord>((event, emit) async {
      emit(state.copyWith(
          isLoading: true, errorMessage: '', dictionaryModel: null));
      try {
        final dictionaryModel = await APIservices.fetchData(event.word);
        emit(state.copyWith(
          dictionaryModel: dictionaryModel,
          isLoading: false,
          errorMessage: '',
        ));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Error: ${e.toString()}',
        ));
      }
    });
  }
}
