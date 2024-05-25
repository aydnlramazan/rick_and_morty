import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/character.dart';
import '../models/episode.dart';
import '../services/api_service.dart';

class EpisodePage extends StatefulWidget {
  @override
  _EpisodePageState createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  late Future<Episode> futureEpisode;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureEpisode = apiService.fetchCharacter(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rick and Morty Episode'),
      ),
      body: Center(
        child: FutureBuilder<Episode>(
          future: futureEpisode,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(snapshot.data!.name),
                  Text(snapshot.data!.airDate),
                  Text(snapshot.data!.episode),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.characters.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder<Character>(
                          future: apiService.fetchCharacter(int.parse(snapshot
                              .data!.characters[index]
                              .split('/')
                              .last)),
                          builder: (context, charSnapshot) {
                            if (charSnapshot.hasData) {
                              return ListTile(
                                title: Text(charSnapshot.data!.name),
                                subtitle: Text(charSnapshot.data!.status),
                              );
                            } else if (charSnapshot.hasError) {
                              return Text('${charSnapshot.error}');
                            }
                            return CircularProgressIndicator();
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
