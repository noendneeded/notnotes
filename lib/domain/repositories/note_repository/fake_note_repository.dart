import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:notnotes/domain/entities/note/note_entity.dart';
import 'package:notnotes/domain/repositories/note_repository/i_note_repository.dart';

class FakeNoteRepository implements INoteRepository {
  FakeNoteRepository();

  @override
  Future<void> init() {
    return Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Future<List<NoteEntity>> getAllNotes() async {
    final String response = await rootBundle.loadString('assets/notes.json');
    final List<dynamic> data = jsonDecode(response);

    return data.map((json) {
      return NoteEntity(
        id: json['id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        content: json['content'] as String? ?? '',
        created: DateTime.parse(json['created'] as String),
        updated: DateTime.parse(json['updated'] as String),
        categoryId: '',
      );
    }).toList();
  }

  @override
  Future<NoteEntity> getNoteById(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<void> createOrUpdateNote(NoteEntity note) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteNote(String id) async {
    throw UnimplementedError();
  }
}
