import 'package:flutter/material.dart';
import 'package:notnotes/domain/repositories/category_repository/i_category_repository.dart';
import 'package:notnotes/domain/repositories/note_repository/i_note_repository.dart';

class AdminViewModel extends ChangeNotifier {
  final BuildContext context;
  final INoteRepository noteRepository;
  final ICategoryRepository categoryRepository;

  AdminViewModel({
    required this.context,
    required this.noteRepository,
    required this.categoryRepository,
  }) {
    _asyncInit();
  }

  _asyncInit() async {}

  /// Переход на страницу 'List'
  openListPage() async {}
}
