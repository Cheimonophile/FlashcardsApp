library flashcards_app.frontend.deck_selection_screen;

import 'dart:convert';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flashcards_app/app.dart';
import 'package:flashcards_app/src/backend/app_data_access.dart';
import 'package:flashcards_app/src/backend/deck_data_access.dart';
import 'package:flashcards_app/src/data/config.dart';
import 'package:flashcards_app/src/data/deck.dart';
import 'package:flashcards_app/src/frontend/screen.dart';
import 'package:flutter/material.dart';

import 'deck_dashboard_screen.dart';
import 'dialogs.dart';

class DeckSelectionScreen extends Screen {
  const DeckSelectionScreen({super.key});

  @override
  createState() => _DeckSelectionScreenState();
}

class _DeckSelectionScreenState extends ScreenState<DeckSelectionScreen, dynamic> {
  // constructor
  _DeckSelectionScreenState();

  @override
  Set<ScreenShortcut> shortcuts = {};

  /// callback when a file is dragged into the frame
  ///
  /// Returns a Widget that should be pushed onto the navigator
  onFilesDragged(DropDoneDetails details) => lock(() async {
        var deckDaos = await AppDao.deckDrop(details);
        if (deckDaos == null) {
          throw Exception("Something went wrong opening the deckfile");
        }
        if (deckDaos.isEmpty) {
          throw Exception("Not enough files dropped");
        }
        if (details.files.length > 1) {
          throw Exception("Too many files dropped");
        }
        pushRoute(
          DeckDashboardScreen(details.files[0].path, deckDaos[0]).route,
        ).then((e) {});
      });

  @override
  buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Decks")),
      body: DropTarget(
        onDragDone: onFilesDragged,
        child: const Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(child: Text("Drag deckfile to open")),
        ),
      ),
    );
  }
}
