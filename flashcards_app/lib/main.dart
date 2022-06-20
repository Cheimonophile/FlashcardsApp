library flashcards_app;

import 'package:flashcards_app/src/backend/data_access.dart';
import 'package:flutter/material.dart';
import 'src/frontend/deck_selection_screen.dart';

void main() {
  runApp(FlashcardsApp());
}

class FlashcardsApp extends StatelessWidget {
  FlashcardsApp({super.key}) {
    Dao.init();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(brightness: Brightness.light),
        darkTheme: ThemeData(brightness: Brightness.dark),
        home: const AppHome()
      );
}

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {

  _AppHomeState() {
    Dao.init(onLoad: () {
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) => Dao.ready
      ? const DeckSelectionScreen()
      : const Scaffold(body: Center(child: CircularProgressIndicator()));
}
