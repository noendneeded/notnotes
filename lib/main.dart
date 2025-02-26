import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notnotes/app.dart';
import 'package:notnotes/domain/di/injection.dart';
import 'package:notnotes/domain/repositories/category_repository/i_category_repository.dart';
import 'package:notnotes/domain/repositories/note_repository/i_note_repository.dart';

void main() async {
  /// Настройка зависимостей --- GetIt
  setupDependencies();

  /// Инициализация локали --- Intl
  await initializeDateFormatting('ru_RU', null);

  /// Инициализация данных --- Hive
  await Hive.initFlutter();

  /// Инициализация репозиториев --- GetIt
  await getIt<INoteRepository>().init();
  await getIt<ICategoryRepository>().init();

  /// Запуск приложения --- Flutter
  runApp(const App());
}
