library flashcards_app;

import 'package:flashcards_app/src/backend/application_data_access.dart';
import 'package:flashcards_app/src/frontend/deck_selection_screen.dart';
import 'package:flutter/material.dart';
import 'src/frontend/deck_selection_screen.dart';

void main() {
  runApp(const FlashcardsApp());
}

class FlashcardsApp extends StatelessWidget {
  const FlashcardsApp({super.key});

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
    AppDao.init(onLoad: () {
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) => AppDao.ready
      ? const DeckSelectionScreen()
      : const Scaffold(body: Center(child: CircularProgressIndicator()));
}
