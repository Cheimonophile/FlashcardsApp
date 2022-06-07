// GENERATED CODE - DO NOT MODIFY BY HAND

part of flashcards_app.data.deck;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deck _$DeckFromJson(Map<String, dynamic> json) => Deck(
      cards: (json['cards'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Card.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      tags: (json['tags'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Tag.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$DeckToJson(Deck instance) => <String, dynamic>{
      'cards': instance.cards,
      'tags': instance.tags,
    };
