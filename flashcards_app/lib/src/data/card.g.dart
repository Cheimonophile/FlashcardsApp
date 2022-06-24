// GENERATED CODE - DO NOT MODIFY BY HAND

part of flashcards_app.data.card;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      frontText: json['frontText'] as String,
      backText: json['backText'] as String,
      score: (json['score'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'frontText': instance.frontText,
      'backText': instance.backText,
      'score': instance.score,
    };
