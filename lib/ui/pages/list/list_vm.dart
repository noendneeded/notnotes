import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notnotes/data/providers/local_data_providers.dart';
import 'package:notnotes/domain/entities/category/category_entity.dart';
import 'package:notnotes/domain/entities/note/note_entity.dart';
import 'package:notnotes/domain/repositories/category_repository/i_category_repository.dart';
import 'package:notnotes/domain/repositories/note_repository/i_note_repository.dart';
import 'package:notnotes/domain/services/notification_service.dart';
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
  int pinnedCount = 0;

  late List<CategoryEntity> categories;
  int categorySelected = 0;

  final TextEditingController listController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  final List<Color> categoryColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.black,
  ];
  Color categoryColor = Colors.white;

  bool _isLoading = true;

  bool _shouldShowPermissionsSheet = false;
  bool get shouldShowPermissionsSheet => _shouldShowPermissionsSheet;

  late final StreamSubscription<String> _notificationSub;

  /// Getter для статуса
  bool get isLoading => _isLoading;

  ValueNotifier<bool> isOpen = ValueNotifier(false);

  ListViewModel({
    required this.context,
    required this.noteRepository,
    required this.categoryRepository,
  }) {
    _asyncInit();
    _checkPermissionsOnStart();

    _notificationSub = NotificationService.onNotificationClick.listen(
      _onNotificationTap,
    );

    NotificationService.getInitialNotificationPayload().then((payload) async {
      if (payload == null) return;

      try {
        final note = await noteRepository.getNoteById(payload);
        note.remindAt = null;
        await noteRepository.createOrUpdateNote(note);
        await NotificationService.cancel(payload.hashCode);
      } catch (_) {}

      await _onNotificationTap(payload);
    });
  }

  Future<void> _asyncInit() async {
    _notes = [];
    notesFiltered = [];
    categories = [];

    await refresh();
  }

  Future<void> _onNotificationTap(String noteId) async {
    await refresh(categoryIndex: categorySelected);

    NoteEntity note;
    try {
      note = await noteRepository.getNoteById(noteId);
    } catch (e) {
      return;
    }

    // ignore: use_build_context_synchronously
    final result = await context.push(
      '${AppRoutes.list}/${AppRoutes.note}',
      extra: note,
    );

    if (result == true) {
      await refresh(categoryIndex: categorySelected);
    }
  }

  Future<void> _checkPermissionsOnStart() async {
    final isNotificationsEnabled =
        await NotificationService.areNotificationsEnabled();
    final isExactAlarmsEnabled =
        await NotificationService.areExactAlarmsPermitted();

    if (!isNotificationsEnabled || !isExactAlarmsEnabled) {
      _shouldShowPermissionsSheet =
          !(await ConfigLocalDataProvider().getPermissionsRequested());

      notifyListeners();
    }
  }

  /// Запрос разрешений на уведомления и точные будильники
  Future<void> requestPermissions() async {
    await NotificationService.requestPermissions();
  }

  Future<void> markPermissionsRequested() async {
    await ConfigLocalDataProvider().setPermissionsRequested();

    _shouldShowPermissionsSheet = false;

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
    categories = await categoryRepository.getAllCategories();
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
          .where(
            (note) =>
                note.title.toLowerCase().contains(query) ||
                (note.contentText != null &&
                    note.contentText!.toLowerCase().contains(query)),
          )
          .toList();
    }

    /// Закрепление
    notesFiltered.sort((a, b) {
      if (a.pinned != b.pinned) {
        return a.pinned ? -1 : 1;
      }
      return b.updated.compareTo(a.updated);
    });

    pinnedCount = notesFiltered.where((note) => note.pinned).length;

    noteStates.clear();
    for (int i = 0; i < notesFiltered.length; i++) {
      noteStates[i] = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Получить состояние закрепления заметок (закреплены или нет)
  bool getCommonNotesPinMode() {
    final selectedIndices = noteStates.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    for (var index in selectedIndices) {
      if (!notesFiltered[index].pinned) {
        return true;
      }
    }

    return false;
  }

  /// Закрепление заметок
  pinNotes() {
    final mode = getCommonNotesPinMode();

    final selectedIndices = noteStates.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    for (var index in selectedIndices) {
      final note = NoteEntity(
        id: notesFiltered[index].id,
        title: notesFiltered[index].title,
        contentText: notesFiltered[index].contentText,
        categoryId: notesFiltered[index].categoryId,
        created: notesFiltered[index].created,
        updated: notesFiltered[index].updated,
        pinned: mode,
      );

      noteRepository.createOrUpdateNote(note);
    }

    refresh(categoryIndex: categorySelected);
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
      final updatedNote = notesFiltered[index];
      updatedNote.categoryId = id;

      await noteRepository.createOrUpdateNote(updatedNote);
    }

    await refresh(categoryIndex: categorySelected);
  }

  /// Выбор категории
  selectCategory(int index) {
    categorySelected = index;

    notifyListeners();

    filter();
  }

  /// Установка цвета категории
  setCategoryColor(Color color) {
    categoryColor = color;
    notifyListeners();
  }

  /// Очистка контроллера категорий
  clearCategoryController({bool useFuture = false}) async {
    /// Задержка нужна для плавности очистки текстового поля
    /// Поле очистится за интерфейсом
    if (useFuture) await Future.delayed(const Duration(milliseconds: 300));

    categoryController.clear();
    notifyListeners();
  }

  /// Создание категории
  createCategory() async {
    if (categoryController.value.text.isEmpty) {
      DefaultToast.show('Название не может быть пустым');
      return;
    }

    if (categories
        .any((category) => category.name == categoryController.value.text)) {
      DefaultToast.show('Имя категории должно быть уникальным');
      return;
    }

    final category = CategoryEntity(
      id: Uuid().v4(),
      name: categoryController.value.text.trim(),
      created: DateTime.now(),
    );

    clearCategoryController();

    categoryRepository.createOrUpdateCategory(category);

    refresh(categoryIndex: categorySelected);
  }

  /// Редактирование категории
  editCategory(String id) async {
    if (categoryController.value.text.isEmpty) {
      DefaultToast.show('Название не может быть пустым');
      return;
    }

    if (categories
        .any((category) => category.name == categoryController.value.text)) {
      DefaultToast.show('Имя категории должно быть уникальным');
      return;
    }

    final oldCategory = categories.singleWhere((category) => category.id == id);

    final category = CategoryEntity(
      id: oldCategory.id,
      name: categoryController.value.text,
      created: oldCategory.created,
    );

    clearCategoryController();

    categoryRepository.createOrUpdateCategory(category);

    refresh(categoryIndex: categorySelected);
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
    await Future.wait(
      noteStates.entries.where((entry) => entry.value).map(
            (entry) => noteRepository.deleteNote(notesFiltered[entry.key].id),
          ),
    );

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
      await refresh(categoryIndex: categorySelected);
    }
  }

  /// Переход на страницу 'Note' с передачей категории
  openNotePageWithCategory(NoteType type) async {
    final result = await context.push(
      '${GoRouterState.of(context).fullPath!}/${AppRoutes.note}',
      extra: NoteEntity(
        id: 'new',
        title: '',
        contentText: '',
        contentItems: [],
        categoryId: categories[categorySelected].id,
        created: DateTime.now(),
        updated: DateTime.now(),

        /// Тип
        type: type,
      ),
    );

    if (result == true) {
      await refresh(categoryIndex: categorySelected);
    }
  }

  /// Переход на страницу 'Note' с передачей заметки
  openNotePageWithIndex(int index) async {
    final result = await context.push(
      '${GoRouterState.of(context).fullPath!}/${AppRoutes.note}',
      extra: notesFiltered[index],
    );

    if (result == true) {
      await refresh(categoryIndex: categorySelected);
    }
  }

  @override
  void dispose() {
    _notificationSub.cancel();
    super.dispose();
  }
}
