part of 'search_bloc.dart';

class SearchEvent {}

class SearchWord extends SearchEvent {
  final String word;
  SearchWord(this.word);
}
