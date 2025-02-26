import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity {
  CategoryEntity({
    required this.id,
    required this.name,
    this.description = '',
  });

  final String id;

  @JsonKey(defaultValue: '')
  String name;

  @JsonKey(defaultValue: '')
  String description;

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);
}
