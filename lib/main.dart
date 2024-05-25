import 'package:flutter/material.dart';
import 'pages/episode_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty App',
      home: EpisodePage(),
    );
  }
}
