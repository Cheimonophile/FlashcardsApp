library flashcards_app.backend.deck_selection_screen;

import 'dart:convert';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flashcards_app/src/backend/app_data_access.dart';
import 'package:flashcards_app/src/data/config.dart';
import 'package:flashcards_app/src/data/deck.dart';
import 'package:flutter/material.dart';

import 'deck_dashboard.dart';
import 'dialogs.dart';

class DeckSelectionScreen extends StatefulWidget {
  const DeckSelectionScreen({super.key});

  @override
  State<DeckSelectionScreen> createState() => _DeckSelectionScreenState();
}

class _DeckSelectionScreenState extends State<DeckSelectionScreen> {
  // state
  int disabled = 0;

  // constructor
  _DeckSelectionScreenState();

  /// function that locks the ui while performing operations
  Future<T> _action<T>(Future<T> Function() f) async {
    setState(() => disabled++);
    return f().catchError((e) {
      Dialogs.alert(context, e.toString());
    }).whenComplete(() {
      setState(() => disabled--);
    });
  }

  /// callback when a file is dragged into the frame
  /// 
  /// Returns a Widget that should be pushed onto the navigator
  _onFilesDragged(DropDoneDetails details) => _action(() async {
    if(details.files.isEmpty) {
      Dialogs.alert(context, "Not enough files dropped");
      return null;
    }
    if(details.files.length > 1) {
      Dialogs.alert(context, "Too many files dropped");
      return null;
    }
    var fileString = await details.files[0].readAsString();
    var deck = Deck.fromJson(jsonDecode(fileString));

    return Future(() {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => DeckDashboard(details.files[0].path, deck),
      ));
    });
  });
  

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled > 0,
      child: Scaffold(
        appBar: AppBar(title: const Text("Decks")),
        body: DropTarget(
          onDragDone: _onFilesDragged,
          child: const Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Text("Drag deckfile to open")
            ),
          ),
        ),
      ),
    );
  }
}
