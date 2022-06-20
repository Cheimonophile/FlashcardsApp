library flashcards_app;

import 'package:flashcards_app/src/backend/app_data_access.dart';
import 'package:flashcards_app/src/frontend/app_home.dart';
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
