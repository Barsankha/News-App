import 'package:channel_1/main/dictionary/bloc/search_bloc.dart';
import 'package:channel_1/main/dictionary/bloc/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: use_key_in_widget_constructors
class SearchPage extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final ipadding = isSmallScreen ? 8.0 : 16.0;
    final ifontsize = isSmallScreen ? 18.0 : 20.0;
    final bottompadding = isSmallScreen ? 40.0 : 60.0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("WordPedia"),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: ipadding,
            left: ipadding,
            right: ipadding,
            bottom: bottompadding),
        child: Column(
          children: [
            // Search TextField
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: "Search...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchWord(context);
                  },
                ),
              ),
              onSubmitted: (value) {
                _searchWord(context);
              },
            ),
            const SizedBox(height: 20),
            // BlocBuilder for displaying results
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.errorMessage.isNotEmpty) {
                  return Center(child: Text(state.errorMessage));
                } else if (state.dictionaryModel != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.dictionaryModel!.meanings.length,
                      itemBuilder: (context, index) {
                        final meaning = state.dictionaryModel!.meanings[index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                              vertical: ipadding,
                              horizontal: isSmallScreen ? 4.0 : 8.0),
                          child: Padding(
                            padding: EdgeInsets.all(ipadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meaning.partOfSpeech.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ifontsize,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                // Display all definitions with their index
                                Text(
                                  'Definition',
                                  style: TextStyle(fontSize: ifontsize + 2),
                                ),
                                for (int i = 0;
                                    i < meaning.definitions.length;
                                    i++)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: ipadding),
                                    child: Text(
                                      "${i + 1}: ${meaning.definitions[i].definition}",
                                      style: TextStyle(fontSize: ifontsize),
                                    ),
                                  ),
                                // Display all synonyms
                                if (meaning.synonyms.isNotEmpty)
                                  Text(
                                    "Synonyms: ${meaning.synonyms.join(", ")}",
                                    style: TextStyle(fontSize: ifontsize),
                                  ),
                                // Display all antonyms
                                if (meaning.antonyms.isNotEmpty)
                                  Text(
                                    "Antonyms: ${meaning.antonyms.join(", ")}",
                                    style: TextStyle(fontSize: ifontsize),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text("Now You Can Search"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _searchWord(BuildContext context) {
    final word = textEditingController.text.trim();
    if (word.isNotEmpty) {
      BlocProvider.of<SearchBloc>(context).add(SearchWord(word));
    }
  }
}
