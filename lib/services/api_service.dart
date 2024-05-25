// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/episode.dart';
import '../models/character.dart';

class ApiService {
  static const String _baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<Episode>> fetchAllEpisodes() async {
    List<Episode> allEpisodes = [];
    String? nextUrl = '$_baseUrl/episode';

    while (nextUrl != null) {
      final response = await http.get(Uri.parse(nextUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var episodes = List<Episode>.from(
            jsonResponse['results'].map((x) => Episode.fromJson(x)));
        allEpisodes.addAll(episodes);
        nextUrl = jsonResponse['info']['next'];
      } else {
        throw Exception('Failed to load episodes');
      }
    }

    return allEpisodes;
  }

  Future<Character> fetchCharacter(int characterId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/character/$characterId'));

    if (response.statusCode == 200) {
      return Character.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load character');
    }
  }

  Future<List<Character>> searchCharacters(String query) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/character/?name=$query'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return List<Character>.from(
          jsonResponse['results'].map((x) => Character.fromJson(x)));
    } else {
      throw Exception('Failed to search characters');
    }
  }
}
