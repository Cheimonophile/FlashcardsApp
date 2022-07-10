library flashcards_app.data.deck;

import 'package:json_annotation/json_annotation.dart';

import 'card.dart';

part 'deck.g.dart';



/// Represents an entire deck file
@JsonSerializable()
class Deck {

  // static fields
  static const defaultCardsPerReview = 10;

  // fields
  final Map<String, Card> cards;
  final Set<String> tags;
  int cardsPerReview;

  // accessors
  // Deck get clone => Deck(
  //   cards: List.from(cards),
  //   tags: Set.from(tags),
  // );

  /// constructor
  Deck({
    required this.cards,
    required this.tags,
    this.cardsPerReview = Deck.defaultCardsPerReview,
  });

  /// empty constructor
  factory Deck.empty() => Deck(
    cards: {},
    tags: {}
  );

  // JSON functions
  factory Deck.fromJson(Map<String, dynamic> json) => _$DeckFromJson(json);
  Map<String, dynamic> toJson() => _$DeckToJson(this);
}