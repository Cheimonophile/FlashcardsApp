library flashcards_app;

import 'package:flashcards_app/src/backend/data_access.dart';
import 'package:flutter/material.dart';
import 'src/frontend/deck_selection_screen.dart';

void main() {
  runApp(const FlashcardsApp());
}

class FlashcardsApp extends StatelessWidget {
  const FlashcardsApp({super.key});

  @override
  Widget build(BuildContext context) => Dao.ready
      ? const MaterialApp(home: CircularProgressIndicator())
      : const MaterialApp(home: DeckSelectionScreen());
}
