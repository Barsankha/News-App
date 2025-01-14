import 'package:channel_1/main/dictionary/service/dictionary_model.dart';

class SearchState {
  final bool isLoading;
  final String errorMessage;
  final DictionaryModel? dictionaryModel;

  SearchState(
      {this.isLoading = false, this.errorMessage = '', this.dictionaryModel});

  SearchState copyWith({
    bool? isLoading,
    String? errorMessage,
    DictionaryModel? dictionaryModel,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      dictionaryModel: dictionaryModel ?? this.dictionaryModel,
    );
  }
}
