library flashcards_app.data.card;

import 'package:color_models/color_models.dart';
import 'package:flashcards_app/src/backend/deck_data_access.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

/// represents a single card
@JsonSerializable()
class Card {
  // meta information
  static const double minScore = 0;
  static const double maxScore = 100;

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

  /// get the percent value of the card's score
  double get front2backPercent => front2backScore / maxScore;
  double get back2frontPercent => back2frontScore / maxScore;

  // JSON functions
  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
  Map<String, dynamic> toJson() => _$CardToJson(this);
}

/// Type for holding a review card
class ReviewCard {
  int timesSeen = 0;
  final MetaCard metaCard;
  final FlipDirection flipDirection;
  ReviewCard(this.metaCard, this.flipDirection);

  // score accessors abstract card direction
  double get score => flipDirection == FlipDirection.front2back
      ? metaCard.card.front2backScore
      : metaCard.card.back2frontScore;
  set score(double newScore) => flipDirection == FlipDirection.front2back
      ? metaCard.card.front2backScore = newScore
      : metaCard.card.back2frontScore = newScore;
}

/// the flip direction of the card
enum FlipDirection {
  front2back,
  back2front,
}

/// extension for card percents
extension CardScore on double {
  double get percent => this / Card.maxScore;
  static final NumberFormat _percentPattern = NumberFormat.percentPattern();
  String formatPercent() => _percentPattern.format(this);

  /// format a percent
  /// get the percent's color
  Color get color =>
      HSVColor.lerp(
        HSVColor.fromColor(Colors.red),
        HSVColor.fromColor(Colors.green),
        this,
      )!.toColor();
}
