library flashcards_app.algorithms.pick_cards;

import 'package:flashcards_app/src/backend/deck_data_access.dart';
import 'package:flashcards_app/src/data/card.dart';

/// enum with valid
class PickCardsAlgo {
  final Iterable<MetaCard> Function(int, Iterable<MetaCard>) pick;

  // private constructor
  PickCardsAlgo._(this.pick);

  /// pick function picks the lowest weighted cards
  static PickCardsAlgo get lowestWeights => PickCardsAlgo._(
        (numCards, metaCards) => (metaCards.toList()
              ..shuffle()
              ..sort((a, b) => a.card.score <= b.card.score ? -1 : 1))
            .sublist(0, numCards),
      );
}
