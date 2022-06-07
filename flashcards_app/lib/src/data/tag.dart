library flashcards_app.data.tag;

import 'package:json_annotation/json_annotation.dart';
part 'tag.g.dart';

/// represents a tag
@JsonSerializable()
class Tag {

  Tag();

  // JSON functions
  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}