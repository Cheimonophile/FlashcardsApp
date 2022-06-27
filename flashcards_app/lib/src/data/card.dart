library flashcards_app.data.card;

import 'package:flashcards_app/src/backend/deck_data_access.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

/// represents a single card
@JsonSerializable()
class Card {
  // meta information
  static const double minScore = 0;
  static const double maxScore = 7;

  // data
  String frontText;
  String backText;
  double front2backScore;
  double back2frontScore;

  // constructor
  Card({
    required this.frontText,
    required this.backText,
    this.front2backScore = 0,
    this.back2frontScore = 0,
  });

  // JSON functions
  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
  Map<String, dynamic> toJson() => _$CardToJson(this);
}

/// stores a card along with some metadata
class MetaCard {
  final int index;
  final Card card;
  MetaCard(this.index, this.card);
}

/// Type for holding a review card
class ReviewCard {
  int timesSeen = 0;
  bool? gotCorrect;
  final MetaCard metaCard;
  final FlipDirection flipDirection;
  ReviewCard(this.metaCard, this.flipDirection);

  // get the card's score, considering its direction
  double get score => flipDirection == FlipDirection.front2back
      ? metaCard.card.front2backScore
      : metaCard.card.back2frontScore;
}

/// the flip direction of the card
enum FlipDirection {
  front2back,
  back2front,
}
