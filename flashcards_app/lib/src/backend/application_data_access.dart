library flashcards_app.backend.application_data_access;


import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flashcards_app/src/data/config.dart';
import 'package:flashcards_app/src/data/deck.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part "file_system_interface.dart";


abstract class AppDao {

  static bool _ready = false;
  static late Config _config;

  // init the Dao
  static init({Function()? onLoad}) {
    Future.wait([
      _FSI.loadConfig().then((config) => _config = config)
    ]).then((r) {
      if(onLoad != null) {
        onLoad();
      }
      _ready = true;
    });
  }

  // accessors
  static bool get ready => _ready;
  static Config? get config  => _config.clone();

  /// edit function to make sure everything is up to date
  static Future<T?> _edit<T>(Future<T> Function() f) async {
    return f().then((value) {
      _FSI.saveConfig(_config);
      return value;
    });
  }

  /// function to edit the config object
  static editConfig(Function(Config?) f) => _edit(() async {
    f(_config);
  });

  /// imports a new deck file
  static Future importDeckFile() => _edit(() async {
    var deckFileName = await _FSI.importDeckFile();
    if (deckFileName != null) {
      _config.addDeckFile(deckFileName);
    }
  });

  /// saves a deck file
  static Future saveDeck(String path, Deck deck) => _edit(() async {
    var deckJson = jsonEncode(deck.toJson());
    _FSI.saveFile(path, deckJson);
  });

  /// imports a new deck file
  // static Future loadDeckFile() => _edit(() async {
  //   var deckFilePath = await FSI.pickDeckFile();
  //   if (deckFilePath != null) {
  //     _config.addDeckFile(deckFilePath);
  //   }
  // });

  /// creates a new deck file
  // static Future newDeckFile() => _edit(() async {
  //   var deckFileName = await FSI.createDeckFile();
  //   if (deckFileName != null) {
  //     _config.addDeckFile(deckFileName);
  //   }
  // });

  /// delets a deck file
  // static Future deleteDeckFile(String deckFileName) => _edit(() async {
  //   await FSI.deleteDeckFile(deckFileName);
  //   _config.removeDeckFile(deckFileName);
  // });

  // /// get open a deck file
  // static Future<Deck?> openDeckFile(String deckFileName) => _edit(() async {
  //   var deck = (await FSI.loadDeckFile(deckFileName))!;
  //   _config.addDeckFile(deckFileName);
  //   return deck;
  // });
}