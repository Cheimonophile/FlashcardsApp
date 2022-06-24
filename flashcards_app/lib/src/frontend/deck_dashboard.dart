library flashcards_app.frontend.deck_dashboard;

import 'dart:io';

import 'package:flashcards_app/src/backend/app_data_access.dart';
import 'package:flashcards_app/src/backend/deck_data_access.dart';
import 'package:flashcards_app/src/frontend/dialogs.dart';
import 'package:flashcards_app/src/frontend/new_card_screen.dart';
import 'package:flashcards_app/src/frontend/visual_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flashcards_app/src/data/deck.dart';

import 'package:path/path.dart' as path;

part 'deck_dashboard/cards_table.dart';
part 'deck_dashboard/card_row.dart';

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
  late String fileName = path.basename(File(widget.path).path);
  int pageIndex = 0;

  // controllers
  CardsTableController cardsTableController = CardsTableController();

  /// function that locks the ui while performing operations
  Future<T> _action<T>(Future<T> Function() f) async {
    setState(() {
      disabled++;
    });
    return f().catchError((e) {
      Dialogs.alert(context, e.toString());
    }).whenComplete(() {
      setState(() => disabled--);
    });
  }

  /// save the file
  Future _saveDeck() => _action(() async {
        widget.deckDao.save();
      });

  /// function that determines whether or not the scope can be popped
  Future<bool> _onWillPop() => _action(() async {
        if (!widget.deckDao.edited) return true;
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

  // list of pages for the
  late List<_NavBarItem> pages = [
    _NavBarItem("Review", () => const Text("Review")),
    _NavBarItem("Deck", () => const Text("Deck")),
    _NavBarItem(
      "Cards",
      () => _CardsTable(widget.deckDao, cardsTableController, (f) => _action(f)),
    ),
  ];

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: _onWillPop,
      child: IgnorePointer(
        ignoring: disabled > 0,
        child: Scaffold(
            appBar: AppBar(
                title: Text(fileName + (widget.deckDao.edited ? "*" : ""))),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: pages[pageIndex].pageBuilder()

                // Row(
                //   children: [
                //     // side bar
                //     IntrinsicWidth(
                //       child: Column(
                //         children: [
                //           // deck buttons
                //           const Text("Deck"),
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.stretch,
                //             children: deckButtons.entries
                //                 .map((entry) => Padding(
                //                       padding: const EdgeInsets.only(top: 8.0),
                //                       child: OutlinedButton(
                //                         onPressed: entry.value,
                //                         child: Text(entry.key),
                //                       ),
                //                     ))
                //                 .toList(),
                //           ),
                //           const Divider(),
                //           // card buttons
                //           const Text("Cards"),
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.stretch,
                //             children: cardButtons.entries
                //                 .map((entry) => Padding(
                //                       padding: const EdgeInsets.only(top: 8.0),
                //                       child: OutlinedButton(
                //                         onPressed: entry.value,
                //                         child: Text(entry.key),
                //                       ),
                //                     ))
                //                 .toList(),
                //           ),
                //           const Divider(),
                //           // tag buttons
                //           const Text("Tags"),
                //         ],
                //       ),
                //     ),
                //     const VerticalDivider(),
                //     // main area
                //     Expanded(
                //       child: _CardsTable(widget.deckDao, cardsTableController),
                //     ),
                //   ],
                // ),
                ),
            // persistentFooterButtons: [
            //   Expanded(
            //     child: TextButton(
            //       onPressed: () {},
            //       child: Text("Test Button"),
            //     ),
            //   ),
            // ],
            // bottomNavigationBar: BottomNavigationBar(
            //   currentIndex: pageIndex,
            //   items: [
            //     BottomNavigationBarItem(icon: Container(), label: "Deck"),
            //     BottomNavigationBarItem(icon: Container(), label: "Cards"),
            //   ],
            // ),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                children: pages
                    .asMap()
                    .entries
                    .map((entry) => Expanded(
                          child: TextButton(
                            autofocus: true,
                            onPressed: () => setState(() => pageIndex = entry.key),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  entry.value.name,
                                  style: TextStyle(
                                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                                    decoration: entry.key == pageIndex
                                        ? TextDecoration.underline
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            )),
      ));
}

class _NavBarItem {
  final String name;
  final Widget Function() pageBuilder;

  _NavBarItem(this.name, this.pageBuilder);
}
