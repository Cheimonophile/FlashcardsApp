// GENERATED CODE - DO NOT MODIFY BY HAND

part of flashcards_app.data.card;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      frontText: json['frontText'] as String,
      backText: json['backText'] as String,
      front2backScore: (json['front2backScore'] as num?)?.toDouble() ?? 0,
      back2frontScore: (json['back2frontScore'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'frontText': instance.frontText,
      'backText': instance.backText,
      'front2backScore': instance.front2backScore,
      'back2frontScore': instance.back2frontScore,
    };
