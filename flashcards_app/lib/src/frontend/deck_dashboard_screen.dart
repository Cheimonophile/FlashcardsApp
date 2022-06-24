library flashcards_app.frontend.deck_dashboard_screen;

import 'dart:io';

import 'package:flashcards_app/src/algorithms/pick_cards.dart';
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

import 'nav_bar.dart';

part 'deck_dashboard_screen/cards_dashboard.dart';
part 'deck_dashboard_screen/card_row.dart';
part 'deck_dashboard_screen/review_dashboard.dart';

class DeckDashboardScreen extends StatefulWidget {
  const DeckDashboardScreen(this.path, this.deckDao, {super.key});

  final String path;
  final DeckDao deckDao;

  @override
  State<DeckDashboardScreen> createState() => _DeckDashboardScreenState();
}

class _DeckDashboardScreenState extends State<DeckDashboardScreen> {
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
      cardsTableController.clearSelected();
    });
  }

  /// save the file
  Future _saveDeck() => _action(() async {
        widget.deckDao.save();
      });

  /// maps of buttons for various dashboards
  late Map<String, Function()> deckButtons = {
    // card buttons
    "Save Deck": _saveDeck,
  };

  // list of pages for the
  late List<_NavBarItem> pages = [
    _NavBarItem(
        "Review",
        () => _ReviewDashboard(
              widget.deckDao,
              whileChange: (f) => _action(f),
            )),
    _NavBarItem("Deck", () => const Text("Deck")),
    _NavBarItem(
        "Cards",
        () => _CardsDashboard(
              widget.deckDao,
              cardsTableController,
              whileChange: (f) => _action(f),
            )),
  ];

  @override
  Widget build(BuildContext context) => IgnorePointer(
    ignoring: disabled > 0,
    child: Scaffold(
        appBar: AppBar(
            title: Text(fileName)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: pages[pageIndex].pageBuilder(),
        ),
        bottomNavigationBar: BottomAppBar(
          child: NavBar(
            currentPageIndex: pageIndex,
            pageNames: pages.map((page) => page.name).toList(),
            onPressed: (newPageIndex) =>
                setState(() => pageIndex = newPageIndex),
          ),
        )),
  );
}

class _NavBarItem {
  final String name;
  final Widget Function() pageBuilder;

  _NavBarItem(this.name, this.pageBuilder);
}
