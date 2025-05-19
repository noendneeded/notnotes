import 'package:get_it/get_it.dart';
import 'package:notnotes/domain/repositories/category_repository/category_repository.dart';
import 'package:notnotes/domain/repositories/category_repository/i_category_repository.dart';
import 'package:notnotes/domain/repositories/note_repository/i_note_repository.dart';
import 'package:notnotes/domain/repositories/note_repository/note_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

/// [useFake] - использовать фейковые репозитории?
Future<void> setupDependencies({bool useFake = false}) async {
  /// SharedPreferences
  getIt.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );

  /// INoteRepository
  if (!getIt.isRegistered<INoteRepository>()) {
    getIt.registerLazySingleton<INoteRepository>(
      () => NoteRepository(),
    );
  }

  /// ICategoryRepository
  if (!getIt.isRegistered<ICategoryRepository>()) {
    getIt.registerLazySingleton<ICategoryRepository>(
      () => CategoryRepository(),
    );
  }

  /// Ожидание инициализации
  await getIt.isReady<SharedPreferences>();
}
