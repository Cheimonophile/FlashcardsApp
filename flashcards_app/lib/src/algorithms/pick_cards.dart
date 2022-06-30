library flashcards_app.algorithms.pick_cards;

import 'dart:convert';

import 'package:flashcards_app/src/algorithms/process_review.dart';
import 'package:flashcards_app/src/backend/deck_data_access.dart';
import 'package:flashcards_app/src/data/card.dart';
import 'package:flashcards_app/src/frontend/card_display.dart';


class PickCardsAlgo {
  /// given a list of metacards, picks a sublist of them.
  final Iterable<ReviewCard> Function(
    int numCards,
    Iterable<MetaCard> metaCards, [
    FlipDirection? flipDirection,
  ]) pick;

  // private constructor
  PickCardsAlgo._(this.pick);

  /// pick function picks the lowest weighted cards
  factory PickCardsAlgo.lowestWeights() =>
      PickCardsAlgo._((numCards, metaCards, [flipDirection]) {
        var reviewCards = metaCards
            .expand((metaCard) => [
                  ReviewCard(metaCard, FlipDirection.front2back),
                  ReviewCard(metaCard, FlipDirection.back2front),
                ])
            .where((reviewCard) =>
                flipDirection == null ||
                reviewCard.flipDirection == flipDirection)
            .toList()
          ..shuffle()
          ..sort((a, b) => a.score < b.score ? -1 : 1);
        return reviewCards.sublist(0, numCards);
      });
}
