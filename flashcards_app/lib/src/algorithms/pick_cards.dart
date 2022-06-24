library flashcards_app.algorithms.pick_cards;

import 'package:flashcards_app/src/data/card.dart';

/// enum with valid
class PickCardAlgo {
  final Iterable<Card> Function(int, Iterable<Card>) pick;

  // private constructor
  PickCardAlgo._(this.pick);

  /// pick function picks the lowest
  static PickCardAlgo get lowestWeights => PickCardAlgo._(
        (numCards, cards) => (cards.toList()
              ..sort((a, b) => a.weight <= b.weight ? -1 : 1))
            .sublist(0, numCards)
          ..shuffle(),
      );
}
