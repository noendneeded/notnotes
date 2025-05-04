// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteEntity _$NoteEntityFromJson(Map<String, dynamic> json) => NoteEntity(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? '',
      created: DateTime.parse(json['created'] as String),
      updated: DateTime.parse(json['updated'] as String),
      pinned: json['pinned'] as bool? ?? false,
      remindAt: json['remindAt'] == null
          ? null
          : DateTime.parse(json['remindAt'] as String),
    );

Map<String, dynamic> _$NoteEntityToJson(NoteEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'pinned': instance.pinned,
      'categoryId': instance.categoryId,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
      'remindAt': instance.remindAt?.toIso8601String(),
    };
