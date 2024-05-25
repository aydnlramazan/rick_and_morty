// pages/search_page.dart
import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/api_service.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ApiService apiService = ApiService();
  List<Character> _characters = [];
  bool _isLoading = false;

  void _searchCharacters(String query) async {
    setState(() {
      _isLoading = true;
    });

    final response = await apiService.searchCharacters(query);

    setState(() {
      _characters = response;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Characters'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onSubmitted: _searchCharacters,
            ),
          ),
          _isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                    itemCount: _characters.length,
                    itemBuilder: (context, index) {
                      Character character = _characters[index];
                      return ListTile(
                        leading: Image.network(character.image),
                        title: Text(character.name),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
