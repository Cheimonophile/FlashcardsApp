
library flashcards_app.backend.deck_dashboard;

import 'dart:io';

import 'package:flashcards_app/src/backend/application_data_access.dart';
import 'package:flashcards_app/src/frontend/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flashcards_app/src/data/deck.dart';

import 'package:path/path.dart' as p;






class DeckDashboard extends StatefulWidget {
  const DeckDashboard(this.path, this.deck, {super.key});

  final String path;
  final Deck deck;

  @override
  State<DeckDashboard> createState() => _DeckDashboardState();
}

class _DeckDashboardState extends State<DeckDashboard> {

  int disabled = 0;
  bool edited = false;
  late String fileName = p.basename(File(widget.path).path);

  /// function that locks the ui while performing operations
  Future<T> _action<T>(Future<T> Function() f) async {
    setState(() => disabled++);
    return f().catchError((e) {
      Dialogs.alert(context, e.toString());
    }).whenComplete(() {
      setState(() => disabled--);
    });
  }

  /// save the file
  Future _saveDeck() => _action(() async {
    await AppDao.saveDeck(widget.path, widget.deck);
  });

  /// function that determines whether or not the scope can be popped
  Future<bool> _onWillPop() => _action(() async {
    if(!edited) return true;
    var doSave = await Dialogs.yesNoCancel(context, "Do you want to save $fileName?");
    if(doSave == null) {
      return false;
    }
    else if(doSave == false) {
      return true;
    } 
    else {
      await _saveDeck();
      return true;
    }
  });

  
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: IgnorePointer(
        ignoring: disabled > 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text(fileName + (edited? "*": ""))
          ),
        ),
      ),
    );
  }
}