import 'package:get_it/get_it.dart';
import 'package:notnotes/domain/repositories/category_repository/category_repository.dart';
import 'package:notnotes/domain/repositories/category_repository/i_category_repository.dart';
import 'package:notnotes/domain/repositories/note_repository/fake_note_repository.dart';
import 'package:notnotes/domain/repositories/note_repository/i_note_repository.dart';
import 'package:notnotes/domain/repositories/note_repository/note_repository.dart';

final GetIt getIt = GetIt.instance;

/// [useFake] - использовать фейковые репозитории?
void setupDependencies({bool useFake = false}) {
  /// INoteRepository
  if (!getIt.isRegistered<INoteRepository>()) {
    getIt.registerLazySingleton<INoteRepository>(
      () => useFake ? FakeNoteRepository() : NoteRepository(),
    );
  }

  /// ICategoryRepository
  if (!getIt.isRegistered<ICategoryRepository>()) {
    getIt.registerLazySingleton<ICategoryRepository>(
      () => CategoryRepository(),
    );
  }
}
