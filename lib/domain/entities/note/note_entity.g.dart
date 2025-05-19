// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListItem _$ListItemFromJson(Map<String, dynamic> json) => ListItem(
      text: json['text'] as String,
      checked: json['checked'] as bool? ?? false,
    );

Map<String, dynamic> _$ListItemToJson(ListItem instance) => <String, dynamic>{
      'text': instance.text,
      'checked': instance.checked,
    };

NoteEntity _$NoteEntityFromJson(Map<String, dynamic> json) => NoteEntity(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      type: json['type'] == null
          ? NoteType.text
          : NoteEntity._typeFromJson((json['type'] as num).toInt()),
      contentText: json['contentText'] as String? ?? '',
      contentItems: (json['contentItems'] as List<dynamic>?)
              ?.map((e) => ListItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      contentAudioPath: json['contentAudioPath'] as String?,
      created: DateTime.parse(json['created'] as String),
      updated: DateTime.parse(json['updated'] as String),
      pinned: json['pinned'] as bool? ?? false,
      remindAt: json['remindAt'] == null
          ? null
          : DateTime.parse(json['remindAt'] as String),
      categoryId: json['categoryId'] as String? ?? '',
    );

Map<String, dynamic> _$NoteEntityToJson(NoteEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'pinned': instance.pinned,
      'type': NoteEntity._typeToJson(instance.type),
      'title': instance.title,
      'contentText': instance.contentText,
      'contentItems': instance.contentItems,
      'contentAudioPath': instance.contentAudioPath,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
      'remindAt': instance.remindAt?.toIso8601String(),
    };
