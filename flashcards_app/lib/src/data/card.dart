library flashcards_app.data.card;

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
  double score;

  // constructor
  Card({
    required this.frontText,
    required this.backText,
    this.score = 0,
  });

  // JSON functions
  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
  Map<String, dynamic> toJson() => _$CardToJson(this);
}
