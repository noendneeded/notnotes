import 'package:notnotes/domain/entities/categories/category_entity.dart';

abstract class ICategoryRepository {
  Future<void> init();

  /// Получить список категорий
  Future<List<CategoryEntity>> getCategoryList();

  /// Получить категорию по ID
  Future<CategoryEntity> getCategoryById(String id);

  /// Создать или обновить категорию
  Future<void> createOrUpdateCategory(CategoryEntity category);

  /// Удалить категорию по ID
  Future<void> deleteCategory(String id);
}
