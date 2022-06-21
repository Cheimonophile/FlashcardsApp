library flashcards_app.data.deck;

import 'package:json_annotation/json_annotation.dart';

import 'card.dart';
import 'tag.dart';

part 'deck.g.dart';



/// Represents an entire deck file
@JsonSerializable()
class Deck {

  // fields
  final List<Card> cards;
  final List<String> tags;


  /// default constructor
  Deck({
    this.cards = const [],
    this.tags = const []
  });

  // JSON functions
  factory Deck.fromJson(Map<String, dynamic> json) => _$DeckFromJson(json);
  Map<String, dynamic> toJson() => _$DeckToJson(this);
}