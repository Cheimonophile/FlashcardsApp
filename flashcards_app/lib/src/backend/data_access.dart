library flashcards_app.backend.data_access;


import 'dart:async';

import 'package:flashcards_app/src/backend/file_system_interface.dart';
import 'package:flashcards_app/src/data/config.dart';
import 'package:flashcards_app/src/data/deck.dart';


class Dao {
  bool? _ready;
  Config? _config;

  // constructor
  Dao(Function() onLoad) {
    Future.wait([
      FSI.loadConfig().then((config) => _config = config)
    ]).then((r) {
      onLoad();
      _ready = true;
    });
  }

  // accessors
  Config? get config  => _config?.clone();
  bool get ready => _ready == true;

  /// edit function to make sure everything is up to date
  Future<T?> _edit<T>(Future<T> Function() f) async {
    _ready!;
    return f().then((value) {
      FSI.saveConfig(_config!);
      return value;
    });
  }

  /// function to edit the config object
  editConfig(Function(Config?) f) => _edit(() async {
    f(_config!);
  });

  /// imports a new deck file
  Future importDeckFile() => _edit(() async {
    var deckFileName = await FSI.importDeckFile();
    if (deckFileName != null) {
      _config!.addDeckFile(deckFileName);
    }
  });

  /// creates a new deck file
  Future newDeckFile() => _edit(() async {
    var deckFileName = await FSI.createDeckFile();
    if (deckFileName != null) {
      _config!.addDeckFile(deckFileName);
    }
  });

  /// delets a deck file
  Future deleteDeckFile(String deckFileName) => _edit(() async {
    await FSI.deleteDeckFile(deckFileName);
    _config!.removeDeckFile(deckFileName);
  });

  /// get open a deck file
  Future<Deck?> openDeckFile(String deckFileName) => _edit(() async {
    var deck = (await FSI.loadDeckFile(deckFileName))!;
    _config!.addDeckFile(deckFileName);
    return deck;
  });
}