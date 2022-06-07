// GENERATED CODE - DO NOT MODIFY BY HAND

part of flashcards_app.data.config;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      deckFiles:
          (json['deckFiles'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'deckFiles': instance.deckFiles,
    };
