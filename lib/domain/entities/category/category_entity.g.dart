// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryEntity _$CategoryEntityFromJson(Map<String, dynamic> json) =>
    CategoryEntity(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      created: DateTime.parse(json['created'] as String),
      description: json['description'] as String? ?? '',
      color: json['color'] as String? ?? '0xFFFFFFFF',
    );

Map<String, dynamic> _$CategoryEntityToJson(CategoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'color': instance.color,
      'created': instance.created.toIso8601String(),
    };
