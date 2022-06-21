library flashcards_app.frontend.deck_dashboard;

import 'dart:io';

import 'package:flashcards_app/src/backend/app_data_access.dart';
import 'package:flashcards_app/src/backend/deck_data_access.dart';
import 'package:flashcards_app/src/frontend/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flashcards_app/src/data/deck.dart';

import 'package:path/path.dart' as path;

part 'deck_dashboard/cards_table.dart';

class DeckDashboard extends StatefulWidget {
  const DeckDashboard(this.path, this.deckDao, {super.key});

  final String path;
  final DeckDao deckDao;

  @override
  State<DeckDashboard> createState() => _DeckDashboardState();
}

class _DeckDashboardState extends State<DeckDashboard> {

  // data fields
  int disabled = 0;
  bool edited = false;
  Widget dashboard = const Center(child: CircularProgressIndicator());
  late String fileName = path.basename(File(widget.path).path);

  // widget fields
  late Widget cardsTable =  _CardsTable(widget.deckDao);

  /// function that locks the ui while performing operations
  Future<T> _action<T>(Future<T> Function() f) async {
    setState(() {
      disabled++;
      edited = true;
    });
    return f().catchError((e) {
      Dialogs.alert(context, e.toString());
    }).whenComplete(() {
      setState(() => disabled--);
    });
  }

  /// save the file
  Future _saveDeck() => _action(() async {
        await AppDao.saveDeck(widget.path, widget.deckDao);
        setState(() {
          edited = false;
        });
      });

  /// create a new card
  Future _newCard() => _action(() async {});

  /// function that determines whether or not the scope can be popped
  Future<bool> _onWillPop() => _action(() async {
        if (!edited) return true;
        var doSave = await Dialogs.yesNoCancel(
            context, "Do you want to save $fileName?");
        if (doSave == null) {
          return false;
        } else if (doSave == false) {
          return true;
        } else {
          await _saveDeck();
          return true;
        }
      });

  /// maps of buttons for various dashboards
  late Map<String, Function()> deckButtons = {
    // card buttons
    "Save Deck": _saveDeck,
  };
  late Map<String, Function()> cardButtons = {
    // card buttons
    "New Card": _newCard,
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: IgnorePointer(
          ignoring: disabled > 0,
          child: Scaffold(
            appBar: AppBar(title: Text(fileName + (edited ? "*" : ""))),
            body: Row(
              children: [
                // side bar
                IntrinsicWidth(
                  child: Column(
                    children: [
                      // deck buttons
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: deckButtons.entries
                            .map((entry) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: OutlinedButton(
                                    onPressed: entry.value,
                                    child: Text(entry.key),
                                  ),
                                ))
                            .toList(),
                      ),
                      const Divider(),
                      // card buttons
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: cardButtons.entries
                            .map((entry) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: OutlinedButton(
                                    onPressed: entry.value,
                                    child: Text(entry.key),
                                  ),
                                ))
                            .toList(),
                      ),
                      const Divider(),
                      // tag buttons
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text("T"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(),
                // main area
                Expanded(
                  child: cardsTable,
                ),
              ],
            ),
          ),
        ));
  }
}
