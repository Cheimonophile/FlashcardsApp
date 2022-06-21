import 'dart:convert';

import 'package:flashcards_app/src/data/card.dart';
import 'package:flashcards_app/src/data/deck.dart';

class DeckDao {
  final Deck _deck;
  final List<Function()> _callbacks = [];
  DeckDao(this._deck);

  // adds a callback to be made when the deck is changed
  addCallback(Function() callback) => _callbacks.add(callback);

  // calls calbacks whenever the deck is edited
  _edit(Function() f) {
    f();
    for(final callback in _callbacks) {
      callback();
    }
  }

  // getters
  List<MetaCard> cards() => _deck.cards
      .asMap()
      .entries
      .map((entry) => MetaCard(entry.key, entry.value))
      .toList();

  /// accessors
  Iterable<T> mapCards<T>(T Function(int index, Card card) f) =>
      _deck.cards.asMap().entries.map(
            (entry) => f(entry.key, entry.value),
          );

  /// Json Serialization
  String getJson() => jsonEncode(_deck.toJson());
}

/// stores a card along with some metadata
class MetaCard {
  final int index;
  final Card card;
  MetaCard(this.index, this.card);
}
