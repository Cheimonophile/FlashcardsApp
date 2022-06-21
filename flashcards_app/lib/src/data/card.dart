library flashcards_app.data.card;

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

/// represents a single card
@JsonSerializable()
class Card {
  final String frontText;
  final String backText;

  Card({
    required this.frontText,
    required this.backText,
  });

  // JSON functions
  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
  Map<String, dynamic> toJson() => _$CardToJson(this);
}
