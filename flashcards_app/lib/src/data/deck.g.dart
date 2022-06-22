// GENERATED CODE - DO NOT MODIFY BY HAND

part of flashcards_app.data.deck;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deck _$DeckFromJson(Map<String, dynamic> json) => Deck(
      cards: (json['cards'] as List<dynamic>)
          .map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$DeckToJson(Deck instance) => <String, dynamic>{
      'cards': instance.cards,
      'tags': instance.tags.toList(),
    };
