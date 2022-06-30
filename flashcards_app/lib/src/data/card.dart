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
  static const double maxScore = 1;

  // data
  final String frontText;
  final String backText;
  final double front2backScore;
  final double back2frontScore;

  // constructor
  Card({
    required this.frontText,
    required this.backText,
    this.front2backScore = 0,
    this.back2frontScore = 0,
  });

  /// duplicates the card, changing only the specified fields
  Card to({
    String? frontText,
    String? backText,
    double? front2backScore,
    double? back2frontScore,
  }) =>
      Card(
        frontText: frontText ?? this.frontText,
        backText: backText ?? this.backText,
        front2backScore: front2backScore ?? this.front2backScore,
        back2frontScore: back2frontScore ?? this.back2frontScore
      );

  // JSON functions
  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
  Map<String, dynamic> toJson() => _$CardToJson(this);
}

/// the flip direction of the card
enum FlipDirection {
  front2back,
  back2front,
}
