library flashcards_app.data.deck;

import 'package:json_annotation/json_annotation.dart';

import 'card.dart';

part 'deck.g.dart';



/// Represents an entire deck file
@JsonSerializable()
class Deck {

  // fields
  final List<Card> cards;
  final Set<String> tags;

  // accessors
  // Deck get clone => Deck(
  //   cards: List.from(cards),
  //   tags: Set.from(tags),
  // );

  /// constructor
  Deck({
    required this.cards,
    required this.tags,
  });

  /// empty constructor
  factory Deck.empty() => Deck(
    cards: [],
    tags: {}
  );

  // JSON functions
  factory Deck.fromJson(Map<String, dynamic> json) => _$DeckFromJson(json);
  Map<String, dynamic> toJson() => _$DeckToJson(this);
}