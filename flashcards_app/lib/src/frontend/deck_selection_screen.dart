library flashcards_app.backend.deck_selection_screen;

import 'dart:convert';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flashcards_app/src/backend/data_access.dart';
import 'package:flashcards_app/src/backend/file_system_interface.dart';
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
  late Dao dao = Dao(() => setState(() {}));
  int disabled = 0;

  // constructor
  _DeckSelectionScreenState();

  /// function that locks the ui while performing operations
  void action(Future Function() f) {
    setState(() => disabled++);
    f().catchError((e) {
      Dialogs.alert(context, e.toString());
    }).whenComplete(() {
      setState(() => disabled--);
    });
  }

  /// Executes when the import button is pressed
  ///
  /// Lets the user find a file on their operating system
  void onPressedImportDeckButton() => action(dao.importDeckFile);

  /// Creates a new deckfile when the new button is pressed
  void onPressedNewDeckButton() => action(dao.newDeckFile);

  /// Deletes the deckfile when the new button is pressed
  void onPressedDeleteDeckButton(String deckName) => action(() async {
        var hasPermission = await Dialogs.permission(
            context, "Is it alright to delete deck '$deckName'?");
        if (hasPermission != null && hasPermission) {
          await dao.deleteDeckFile(deckName);
        }
      });

  /// Tries to go to the next screen when a deck has been selected
  void onPressedDeckButton(BuildContext context, String deckFileName) async {
    dao.openDeckFile(deckFileName).then((deck) {
      if(deck != null) {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => DeckDashboard(deckFileName, deck),
        ));
      }
      setState((){});
    });
  }

  /// a map of the buttons that will appear on the bottom bar and their functions
  late final bottomButtons = {
    "Import Deck": onPressedImportDeckButton,
    "New Deck": onPressedNewDeckButton,
  };

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled > 0,
      child: Scaffold(
        appBar: AppBar(title: const Text("Decks")),
        body: DropTarget(
          onDragDone: (details) {
            details.files[0].readAsString().then((fileString) {
              var deck = Deck.fromJson(jsonDecode(fileString));
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => DeckDashboard(details.files[0].path, deck),
              ));
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: ListView(
                children: dao.config?.deckFiles
                        .map((deckName) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  OutlinedButton(
                                    onPressed: () =>
                                        onPressedDeleteDeckButton(deckName),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text("Remove",
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () =>
                                          onPressedDeckButton(context, deckName),
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(deckName)),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList() ??
                    [const CircularProgressIndicator()],
              ),
            ),
          ),
        ),
        persistentFooterButtons: bottomButtons.entries.map((entry) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: entry.value,
                child: Text(entry.key)),
          )).toList(),
      ),
    );
  }
}
