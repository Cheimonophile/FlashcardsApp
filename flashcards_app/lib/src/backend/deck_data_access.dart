import 'dart:convert';

import 'package:flashcards_app/src/data/card.dart';
import 'package:flashcards_app/src/data/deck.dart';

class DeckDao {
  final Deck _deck;
  DeckDao(this._deck);

  Deck get deck => _deck.clone;

  /// accessors
  Iterable<T> mapCards<T>(T Function(int index, Card card) f) =>
      _deck.cards.asMap().entries.map(
            (entry) => f(entry.key, entry.value),
          );

  /// Json Serialization
  String getJson() => jsonEncode(_deck.toJson());
}
