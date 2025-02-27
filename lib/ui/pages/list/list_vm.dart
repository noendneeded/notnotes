import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notnotes/domain/entities/categories/category_entity.dart';
import 'package:notnotes/domain/entities/note/note_entity.dart';
import 'package:notnotes/domain/repositories/category_repository/i_category_repository.dart';
import 'package:notnotes/domain/repositories/note_repository/i_note_repository.dart';
import 'package:notnotes/router/app_routes.dart';
import 'package:notnotes/ui/utils/default_toast/default_toast.dart';
import 'package:uuid/uuid.dart';

class ListViewModel extends ChangeNotifier {
  final BuildContext context;
  final INoteRepository noteRepository;
  final ICategoryRepository categoryRepository;

  late List<NoteEntity> _notes;
  late List<NoteEntity> notesFiltered;
  Map<int, bool> noteStates = {};

  late List<CategoryEntity> categories;
  int categorySelected = 0;

  final TextEditingController listController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  bool _isLoading = true;

  ListViewModel({
    required this.context,
    required this.noteRepository,
    required this.categoryRepository,
  }) {
    _asyncInit();
  }

  /// Getter для статуса
  bool get isLoading => _isLoading;

  Future<void> _asyncInit() async {
    _isLoading = true;
    notifyListeners();

    /// Инициализация заметок
    _notes = await noteRepository.getAllNotes();
    _notes.sort((a, b) => b.updated.compareTo(a.updated));

    for (int i = 0; i < _notes.length; i++) {
      noteStates[i] = false;
    }

    notesFiltered = [];
    notesFiltered.addAll(_notes);

    /// Инициализация категорий
    categories = await categoryRepository.getCategoryList();

    _isLoading = false;
    notifyListeners();
  }

  /// Обновление списка заметок
  refresh({int categoryIndex = 0}) async {
    _isLoading = true;
    notifyListeners();

    /// Обновление заметок
    _notes.clear();
    noteStates.clear();
    notesFiltered.clear();

    _notes.addAll(await noteRepository.getAllNotes());
    _notes.sort((a, b) => b.updated.compareTo(a.updated));

    for (int i = 0; i < _notes.length; i++) {
      noteStates[i] = false;
    }

    notesFiltered.addAll(_notes);

    /// Обновление категорий
    categories.clear();
    categories = await categoryRepository.getCategoryList();
    categorySelected = categoryIndex;

    filter();

    _isLoading = false;
    notifyListeners();
  }

  /// Фильтрация
  filter() {
    _isLoading = true;
    notifyListeners();

    /// Категория
    if (categorySelected == 0) {
      notesFiltered.clear();
      notesFiltered.addAll(_notes);
    } else {
      final categoryid = categories[categorySelected].id;

      notesFiltered.clear();
      notesFiltered =
          _notes.where((note) => note.categoryId == categoryid).toList();
    }

    /// Поиск
    final query = listController.value.text.trim().toLowerCase();

    if (query.isNotEmpty) {
      notesFiltered = notesFiltered
          .where((note) =>
              note.title.toLowerCase().contains(query) ||
              note.content.toLowerCase().contains(query))
          .toList();
    }

    noteStates.clear();
    for (int i = 0; i < notesFiltered.length; i++) {
      noteStates[i] = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Получение общей категории
  String? getCommonSelectedCategoryId() {
    final selectedIndices = noteStates.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (selectedIndices.isEmpty) {
      return null;
    }

    final firstCategoryId = notesFiltered[selectedIndices.first].categoryId;

    final allSame = selectedIndices.every(
      (index) => notesFiltered[index].categoryId == firstCategoryId,
    );

    return allSame ? firstCategoryId : null;
  }

  /// Изменение категории у выделенных заметок
  changeNotesCategory(String id) async {
    final selectedIndices = noteStates.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    for (var index in selectedIndices) {
      final updatedNote = _notes[index];
      updatedNote.categoryId = id;

      noteRepository.createOrUpdateNote(updatedNote);
    }

    await refresh();
  }

  /// Выбор категории
  selectCategory(int index) {
    categorySelected = index;

    notifyListeners();

    filter();
  }

  /// Создание категории
  createCategory() async {
    final category = CategoryEntity(
      id: Uuid().v4(),
      name: categoryController.value.text.trim(),
      created: DateTime.now(),
    );

    categoryController.text = '';

    categoryRepository.createOrUpdateCategory(category);

    refresh(categoryIndex: categories.length);
  }

  /// Удаление категории
  deleteCategory(String id) async {
    if (_notes.where((note) => note.categoryId == id).isNotEmpty) {
      DefaultToast.show('Нельзя удалить категорию с заметками');
      return;
    }

    await categoryRepository.deleteCategory(id);

    await refresh();
  }

  /// Удаление выделенных заметок
  deleteNotes() async {
    await Future.wait(noteStates.entries
        .where((entry) => entry.value)
        .map((entry) => noteRepository.deleteNote(_notes[entry.key].id)));

    await refresh();
  }

  /// Изменить состояние всех заметок
  changeAllNoteTileStates() {
    !noteStates.values.contains(false)
        ? noteStates.updateAll((key, value) => false)
        : noteStates.updateAll((key, value) => true);
    notifyListeners();
  }

  /// Изменить состояние заметки
  changeNoteTileState(int index) {
    noteStates[index] = !(noteStates[index] ?? false);
    notifyListeners();
  }

  /// Переход на страницу 'Note'
  openNotePage() async {
    final result = await context
        .push('${GoRouterState.of(context).fullPath!}/${AppRoutes.note}');

    if (result == true) {
      await refresh();
    }
  }

  openNotePageWithCategory() async {
    final result = await context.push(
      '${GoRouterState.of(context).fullPath!}/${AppRoutes.note}',
      extra: NoteEntity(
        id: Uuid().v4(),
        title: '',
        content: '',
        categoryId: categories[categorySelected].id,
        created: DateTime.now(),
        updated: DateTime.now(),
      ),
    );

    if (result == true) {
      await refresh();
    }
  }

  /// Переход на страницу 'Note' с передачей заметки
  openNotePageWithIndex(int index) async {
    final result = await context.push(
      '${GoRouterState.of(context).fullPath!}/${AppRoutes.note}',
      extra: _notes[index],
    );

    if (result == true) {
      await refresh();
    }
  }

  /// Переход на страницу 'Admin' (только kDebugMode)
  openAdminPage() async {
    final result = await context.push(AppRoutes.admin);

    if (result == true) {
      await refresh();
    }
  }
}
