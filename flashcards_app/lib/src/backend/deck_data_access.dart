import 'dart:convert';
import 'dart:math';

import 'package:flashcards_app/src/algorithms/pick_cards.dart';
import 'package:flashcards_app/src/algorithms/process_review.dart';
import 'package:flashcards_app/src/backend/app_data_access.dart';
import 'package:flashcards_app/src/data/card.dart';
import 'package:flashcards_app/src/data/deck.dart';
import 'package:flashcards_app/src/frontend/card_display.dart';

class DeckDao {
  final Deck _deck;
  final String _path;
  final _rand = Random();
  final _idLen = 8;
  // bool _edited = false;

  DeckDao(this._path, this._deck);

  // getters
  // bool get edited => _edited;

  // gets the cards in the deck as key value pairs
  List<MetaCard> cards() => _deck.cards
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

  /// generates a new id for a card
  String _generateCardID() {
    String id;
    do {
      id = String.fromCharCodes(
        List.generate(_idLen, (_) => _rand.nextInt(33) + 89),
      );
    } while (_deck.cards.containsKey(id));
    return id;
  }

  /// saves the deck in its proper location
  save() async {
    await AppDao.saveDeck(_path, _deck);
    // _edited = false;
  }

  // add multiple cards
  addCards(Iterable<Card> cards) => _edit(() {
        for(final card in cards) {
          _deck.cards[_generateCardID()] = card;
        }
      });

  /// deletes a set of cards from the deck
  removeCards(Iterable<String> cardIDs) => _edit(() {
        for (final cardID in cardIDs) {
          _deck.cards.remove(cardID);
        }
      });

  /// updates cards that are still in the list
  updateCards(Iterable<MetaCard> metaCards) => _edit(() {
    for(final metaCard in metaCards) {
      _deck.cards[metaCard.id] = metaCard.card;
    }
  });

  /// picks a list of cards for review
  List<ReviewCard> pickCards(PickCardsAlgo algo,
      {int? numCards, FlipDirection? flipDirection}) {
    numCards ??= _deck.cards.length;
    if (numCards > _deck.cards.length) {
      throw Exception(
          "Can't pick $numCards cards from a deck with only ${_deck.cards.length} cards");
    }
    return algo.pick(numCards, cards(), flipDirection).toList();
  }

  /// Json Serialization
  String getJson() => jsonEncode(_deck.toJson());
}


/// stores a card along with some metadata
class MetaCard {
  final String id;
  final Card card;
  MetaCard(this.id, this.card);
}
