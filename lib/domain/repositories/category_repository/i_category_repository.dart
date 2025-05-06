import 'package:notnotes/domain/entities/category/category_entity.dart';

abstract class ICategoryRepository {
  Future<void> init();

  /// Получить список категорий
  Future<List<CategoryEntity>> getAllCategories();

  /// Получить категорию по ID
  Future<CategoryEntity> getCategoryById(String id);

  /// Создать или обновить категорию
  Future<void> createOrUpdateCategory(CategoryEntity category);

  /// Удалить категорию по ID
  Future<void> deleteCategory(String id);
}
