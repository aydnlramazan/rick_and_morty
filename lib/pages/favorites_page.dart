// pages/favorites_page.dart
import 'package:flutter/material.dart';
import '../models/character.dart';

class FavoritesPage extends StatelessWidget {
  final List<Character> favorites;
  final Function(Character) removeFavorite;

  FavoritesPage({required this.favorites, required this.removeFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Characters'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          Character character = favorites[index];
          return ListTile(
            leading: Image.network(character.image),
            title: Text(character.name),
            trailing: IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () => removeFavorite(character),
            ),
          );
        },
      ),
    );
  }
}
