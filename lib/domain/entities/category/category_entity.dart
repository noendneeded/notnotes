import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity {
  CategoryEntity({
    required this.id,
    required this.name,
    required this.created,
    this.description = '',
    this.color = '0xFFFFFFFF',
  });

  final String id;

  @JsonKey(defaultValue: '')
  String name;

  @JsonKey(defaultValue: '')
  String description;

  @JsonKey(defaultValue: '0xFFFFFFFF')
  String color;

  final DateTime created;

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);
}
