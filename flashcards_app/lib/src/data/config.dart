library flashcards_app.data.config;

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'config.g.dart';


// constants
const String configFilename = "config.json";

// dictionary indices
const String deckFilesIndex = "deckFiles";

@JsonSerializable()
class Config {

  // fields
  final List<String> deckFiles;

  // constructor
  Config({
    required this.deckFiles
  });

  // empty config
  factory Config.empty() => Config(
    deckFiles: []
  );

  // deep copies the config object
  Config clone() => Config(
    deckFiles: List.from(deckFiles)
  );

  // json functions
  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigToJson(this);

  /// adds a new deck file to the list
  addDeckFile(String deckFile) {
    deckFiles.removeWhere((elem) => elem == deckFile);
    deckFiles.insert(0, deckFile);
  }

  /// removes a deck name
  removeDeckFile(String deckFile) {
    deckFiles.removeWhere((elem) => elem == deckFile);
  }
}


