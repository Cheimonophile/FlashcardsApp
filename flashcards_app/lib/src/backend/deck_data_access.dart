


import 'dart:convert';

import 'package:flashcards_app/src/data/deck.dart';

class DeckDao {
  final Deck _deck;
  DeckDao(this._deck);

  /// Json Serialization
  String getJson() => jsonEncode(_deck.toJson());
}