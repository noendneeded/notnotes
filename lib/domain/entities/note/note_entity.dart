import 'package:json_annotation/json_annotation.dart';

part 'note_entity.g.dart';

@JsonSerializable()
class NoteEntity {
  NoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.categoryId,
    required this.created,
    required this.updated,
  });

  final String id;

  @JsonKey(defaultValue: '')
  String title;

  @JsonKey(defaultValue: '')
  String content;

  @JsonKey(defaultValue: '')
  String categoryId;

  final DateTime created;
  DateTime updated;

  factory NoteEntity.fromJson(Map<String, dynamic> json) =>
      _$NoteEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NoteEntityToJson(this);
}
