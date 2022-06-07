library flashcards_app.backend.file_system_interface;

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flashcards_app/src/data/config.dart';
import 'package:flashcards_app/src/data/deck.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

// constants
const String deckExtension = "deck";
const String deckDirSuffix = "Decks";


/// enum represents different directories that can be accessed
enum _Dir {
  root,
  decks
}
const _dirNames = {
  _Dir.root: "",
  _Dir.decks: "decks"
};

/// namespace for FSI
abstract class FSI {

  /// Picks a file using the OS file picker
  static Future<String?> pickDeckFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [deckExtension],
      lockParentWindow: true
    );
    if (result != null) {
      return result.files.single.path;
    }
    return null;
  }

  /// gets a file and creates it if it doesn't exist
  static File createAndOpen(String filepath) {
    var configFile = File(filepath);
    if(!configFile.existsSync()) {
      configFile.createSync(recursive: true);
    }
    return configFile;
  }

  /// creates a new directory and returns its path
  static Future<String?> createDeckFile() async {
    String? result = await FilePicker.platform.saveFile(
      type: FileType.custom,
      allowedExtensions: [deckExtension],
      lockParentWindow: true
    );
    if(result != null) {
      var deckFile = createAndOpen(result);
      var deck = Deck();
      await deckFile.writeAsString(jsonEncode(deck.toJson()));
    }
    return result;
  }


  /// opens a a deckfile
  static Future<Deck?> loadDeckFile(String deckFileName) async {
    var decksDir = await _getDir(_Dir.decks);
    var deckFilePath = path.join(decksDir.path, deckFileName);
    var deckFile = File(deckFilePath);
    var fileString = deckFile.readAsStringSync();
    var deck = Deck.fromJson(jsonDecode(fileString));
    return deck;
  }

  /// writes the config object
  static Future saveConfig(Config config) async {

    // load the config file
    var appDir = await getApplicationDocumentsDirectory();
    var configPath = path.join(appDir.path, configFilename);
    var configFile = FSI.createAndOpen(configPath);

    // write to the config file
    await configFile.writeAsString(jsonEncode(config.toJson()));
  }

  /// reads the config file
  static Future<Config> loadConfig() async {

    // read the config file the config file
    var appDir = await getApplicationDocumentsDirectory();
    var configPath = path.join(appDir.path, configFilename);
    var configFile = FSI.createAndOpen(configPath);
    var configJson = await configFile.readAsString();

    // generate the config object
    Config config;
    try {
      config = Config.fromJson(jsonDecode(configJson));
    }
    catch(e) {
      config = Config.empty();
    }
    return config;
  }

  /// imports a a deckfile
  static Future<String?> importDeckFile() async {
    var oldPath = await pickDeckFile();
    if(oldPath == null) return null;
    var deckDir = await _getDir(_Dir.decks);
    var deckName = path.basename(oldPath);
    var newPath = path.join(deckDir.path, deckName);
    if(File(newPath).existsSync()) throw Exception("A deck with the name '$deckName' is already imported.");
    File(oldPath).copySync(newPath);
    return path.basename(newPath);
  }

  /// deletes a a deckfile
  static Future deleteDeckFile(String deckName) async {
    var deckDir = await _getDir(_Dir.decks);
    var deckPath = path.join(deckDir.path, deckName);
    var deckFile = File(deckPath);
    if(await deckFile.exists()) {
      await deckFile.delete();
    }
  }

  /// gets the deck folder
  static Future<Directory> _getDir(_Dir dir) async {
    var appDir = await getApplicationDocumentsDirectory();
    var deckDir = Directory(path.join(appDir.path, _dirNames[dir]));
    if(!deckDir.existsSync()) deckDir.createSync(recursive: true);
    return deckDir;
  }
}

