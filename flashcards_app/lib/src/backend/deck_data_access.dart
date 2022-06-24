import 'dart:convert';

import 'package:flashcards_app/src/backend/app_data_access.dart';
import 'package:flashcards_app/src/data/card.dart';
import 'package:flashcards_app/src/data/deck.dart';

class DeckDao {
  final Deck _deck;
  final String _path;
  // bool _edited = false;

  DeckDao(this._path, this._deck);

  // getters
  // bool get edited => _edited;

  // gets the cards in the deck as key value pairs
  List<MetaCard> cards() => _deck.cards
      .asMap()
      .entries
      .map((entry) => MetaCard(entry.key, entry.value))
      .toList();

  /// edit function sets the deckDao as edited
  T _edit<T>(T Function() f) {
    // _edited = true;
    var result = f();
    save();
    return result;
  }

  /// saves the deck in its proper location
  save() async {
    await AppDao.saveDeck(_path, _deck);
    // _edited = false;
  }

  /// adds a card to the deck
  addCard(Card card) => _edit(() {
        _deck.cards.insert(0, card);
      });

  /// deletes a set of cards from the deck
  removeCards(Set<int> cardIndices) => _edit(() {
        var reversedCardIndices = (cardIndices.toList()..sort()).reversed;
        for (final cardIndex in reversedCardIndices) {
          _deck.cards.removeAt(cardIndex);
        }
      });

  /// Json Serialization
  String getJson() => jsonEncode(_deck.toJson());
}

/// stores a card along with some metadata
class MetaCard {
  final int index;
  final Card card;
  MetaCard(this.index, this.card);
}
