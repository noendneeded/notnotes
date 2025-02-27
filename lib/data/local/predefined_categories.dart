import 'package:notnotes/domain/entities/categories/category_entity.dart';

final kPredefinedCategories = [
  CategoryEntity(
    id: 'all',
    name: 'Все',
    created: DateTime(2020, 1, 1),
  ),
  CategoryEntity(
    id: 'pesonal',
    name: 'Личное',
    created: DateTime(2021, 1, 1),
  ),
];
