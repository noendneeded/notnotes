import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:notnotes/data/local/predefined_categories.dart';
import 'package:notnotes/domain/entities/categories/category_entity.dart';
import 'package:notnotes/domain/repositories/category_repository/i_category_repository.dart';

class CategoryRepository implements ICategoryRepository {
  late final Box<String> categoryBox;

  CategoryRepository();

  @override
  Future<void> init() async {
    categoryBox = await Hive.openBox('categoryBox');
  }

  @override
  Future<void> createOrUpdateCategory(CategoryEntity category) async {
    final jsonString = jsonEncode(category.toJson());
    await categoryBox.put(category.id, jsonString);
  }

  @override
  Future<void> deleteCategory(String id) async {
    await categoryBox.delete(id);
  }

  @override
  Future<List<CategoryEntity>> getCategoryList() async {
    final result = <CategoryEntity>[];

    result.addAll(kPredefinedCategories);

    result.addAll(categoryBox.values.map((jsonString) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return CategoryEntity.fromJson(jsonMap);
    }).toList());

    return result;
  }

  @override
  Future<CategoryEntity> getCategoryById(String id) async {
    final jsonString = categoryBox.get(id);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return CategoryEntity.fromJson(jsonMap);
    }
    throw Exception('Категория с id $id не найдена');
  }
}
