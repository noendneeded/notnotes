import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:notnotes/domain/entities/categories/category_entity.dart';
import 'package:notnotes/domain/entities/note/note_entity.dart';
import 'package:notnotes/domain/repositories/category_repository/i_category_repository.dart';
import 'package:notnotes/domain/repositories/note_repository/i_note_repository.dart';
import 'package:notnotes/ui/utils/default_toast/default_toast.dart';
import 'package:uuid/uuid.dart';

class NoteViewModel extends ChangeNotifier {
  final BuildContext context;

  final INoteRepository noteRepository;
  final ICategoryRepository categoryRepository;

  late NoteEntity _note;

  late List<CategoryEntity> categories;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  late bool needToUpdate;

  bool isLoading = false;

  NoteViewModel({
    required this.context,
    required NoteEntity? note,
    required this.noteRepository,
    required this.categoryRepository,
  }) {
    if (note != null) {
      _note = note;

      needToUpdate = true;
    } else {
      final now = DateTime.now();

      _note = NoteEntity(
        id: Uuid().v4(),
        title: '',
        content: '',
        created: now,
        updated: now,
        categoryId: 'all',
      );

      needToUpdate = false;
    }

    titleController.text = _note.title;
    contentController.text = _note.content;

    _asyncInit(note);
  }

  NoteEntity get note => _note;

  Future<void> _asyncInit(NoteEntity? note) async {
    isLoading = true;
    notifyListeners();

    /// Инициализация категорий
    categories = await categoryRepository.getCategoryList();

    isLoading = false;
    notifyListeners();
  }

  /// Создание/обновление заметки
  void createOrUpdateNote() async {
    /// Проверка на корректность заполнения названия заметки
    if (titleController.value.text.isEmpty) {
      DefaultToast.show('Название заметки не может быть пустым');
      return;
    }

    _note.title = titleController.value.text;
    _note.content = contentController.value.text;

    needToUpdate
        ? _note.updated = DateTime.now()
        : _note.updated = _note.created;

    await noteRepository.createOrUpdateNote(_note);

    context.pop(true);
  }

  /// Удаление заметки
  void deleteNote() async {
    if (needToUpdate) {
      await noteRepository.deleteNote(_note.id);
    }

    openListPage(context);
  }

  /// Изменение категории
  void changeCategory({String? id}) {
    if (id != null && id.isNotEmpty) {
      note.categoryId = id;
    } else {
      note.categoryId = 'all';
    }

    notifyListeners();
  }

  /// Возвращает строку для состояния с датой
  String getStateText() {
    final dateTime = _note.updated;
    final isChanged = _note.created.isAtSameMomentAs(_note.updated);

    /// Формат "20 февраля 09:30"
    final formattedDate = DateFormat("d MMMM HH:mm", "ru_RU").format(dateTime);

    return '${isChanged ? 'Создано:' : 'Изменено:'} $formattedDate';
  }

  /// Переход на страницу 'List'
  void openListPage(BuildContext context) {
    // Закрываем NotePage и передаём результат (true)
    context.pop(true);
  }
}
