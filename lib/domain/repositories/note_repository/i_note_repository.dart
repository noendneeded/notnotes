import 'package:notnotes/domain/entities/note/note_entity.dart';

abstract class INoteRepository {
  Future<void> init();

  /// Получить список заметок
  Future<List<NoteEntity>> getAllNotes();

  /// Получить заметку по ID
  Future<NoteEntity> getNoteById(String id);

  /// Создать или обновить заметку
  Future<void> createOrUpdateNote(NoteEntity note);

  /// Удалить заметку по ID
  Future<void> deleteNote(String id);
}
