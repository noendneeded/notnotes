import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity {
  CategoryEntity({
    required this.id,
    required this.name,
    required this.created,
    this.description = '',
  });

  final String id;

  @JsonKey(defaultValue: '')
  String name;

  @JsonKey(defaultValue: '')
  String description;

  final DateTime created;

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);
}
