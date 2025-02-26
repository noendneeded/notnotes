import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:notnotes/domain/entities/note/note_entity.dart';
import 'package:notnotes/domain/repositories/note_repository/i_note_repository.dart';

class NoteRepository implements INoteRepository {
  late final Box<String> noteBox;

  NoteRepository();

  @override
  Future<void> init() async {
    noteBox = await Hive.openBox<String>('noteBox');
  }

  @override
  Future<void> createOrUpdateNote(NoteEntity note) async {
    final jsonString = jsonEncode(note.toJson());
    await noteBox.put(note.id, jsonString);
  }

  @override
  Future<void> deleteNote(String id) async {
    await noteBox.delete(id);
  }

  @override
  Future<List<NoteEntity>> getAllNotes() async {
    return noteBox.values.map((jsonString) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return NoteEntity.fromJson(jsonMap);
    }).toList();
  }

  @override
  Future<NoteEntity> getNoteById(String id) async {
    final jsonString = noteBox.get(id);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return NoteEntity.fromJson(jsonMap);
    }
    throw Exception('Заметка с id $id не найдена');
  }
}
