import 'package:flutter/material.dart';

import '../models/character.dart';
import '../models/episode.dart';
import '../services/api_service.dart';

class EpisodeDetailPage extends StatefulWidget {
  final Episode episode;
  final Function(Character) addFavorite;
  final Function(Character) removeFavorite;
  final List<Character> favorites;

  EpisodeDetailPage({
    required this.episode,
    required this.addFavorite,
    required this.removeFavorite,
    required this.favorites,
  });

  @override
  _EpisodeDetailPageState createState() => _EpisodeDetailPageState();
}

class _EpisodeDetailPageState extends State<EpisodeDetailPage> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.episode.name),
      ),
      body: FutureBuilder<List<Character>>(
        future: Future.wait(
          widget.episode.characters
              .map(
                (url) =>
                    apiService.fetchCharacter(int.parse(url.split('/').last)),
              )
              .toList(),
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Character character = snapshot.data![index];
                bool isFavorite = widget.favorites.contains(character);
                return ListTile(
                  leading: Image.network(character.image),
                  title: Text(character.name),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        widget.removeFavorite(character);
                      } else {
                        widget.addFavorite(character);
                      }
                      setState(() {});
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
