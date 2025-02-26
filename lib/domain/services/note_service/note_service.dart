import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:notnotes/domain/entities/note/note_entity.dart';

class NoteService {
  late final Box<String> noteBox;

  static final NoteService _instance = NoteService._internal();

  factory NoteService() => _instance;

  NoteService._internal();

  Future<void> init() async {
    noteBox = await Hive.openBox<String>('noteBox');
  }

  /// Сохраняет (или обновляет) заметку, используя id как ключ
  Future<void> addOrUpdateNote(NoteEntity note) async {
    await noteBox.put(note.id, jsonEncode(note.toJson()));
  }

  /// Получает заметку по id
  NoteEntity? getNote(String id) {
    final jsonString = noteBox.get(id);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return NoteEntity.fromJson(jsonMap);
    }
    return null;
  }

  /// Возвращает список всех заметок
  List<NoteEntity> getAllNotes() {
    return noteBox.values.map((jsonString) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return NoteEntity.fromJson(jsonMap);
    }).toList();
  }

  /// Удаляет заметку по id
  Future<void> deleteNote(String id) async {
    await noteBox.delete(id);
  }
}
