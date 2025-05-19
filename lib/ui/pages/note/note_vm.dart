import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:notnotes/domain/entities/category/category_entity.dart';
import 'package:notnotes/domain/entities/note/note_entity.dart';
import 'package:notnotes/domain/repositories/category_repository/i_category_repository.dart';
import 'package:notnotes/domain/repositories/note_repository/i_note_repository.dart';
import 'package:notnotes/domain/services/notification_service.dart';
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

  /// Работа со списком
  int listItemsCount = 1;
  List<ListItem> listItems = [];
  List<TextEditingController> listItemControllers = [];

  NoteViewModel({
    required this.context,
    required NoteEntity? note,
    required this.noteRepository,
    required this.categoryRepository,
  }) {
    if (note?.id == 'new') {
      final now = DateTime.now();

      _note = NoteEntity(
        id: Uuid().v4(),
        title: '',
        contentText: '',
        contentItems: [],
        categoryId: note!.categoryId,
        created: now,
        updated: now,
        type: note.type,
      );

      needToUpdate = false;
    } else if (note != null) {
      _note = note;

      needToUpdate = true;
    } else {
      final now = DateTime.now();

      _note = NoteEntity(
        id: Uuid().v4(),
        title: '',
        contentText: '',
        contentItems: [],
        created: now,
        updated: now,
        categoryId: 'all',
      );

      needToUpdate = false;
    }

    titleController.text = _note.title;
    contentController.text = _note.contentText ?? '';

    _asyncInit(note);
  }

  NoteEntity get note => _note;

  Future<void> _asyncInit(NoteEntity? note) async {
    isLoading = true;
    notifyListeners();

    /// Инициализация категорий
    categories = await categoryRepository.getAllCategories();

    changeCategory(id: note?.categoryId);

    /// Инициализация работы со списком
    for (var listItem in note!.contentItems!) {
      listItems.add(listItem);
      listItemControllers.add(TextEditingController(text: listItem.text));
    }

    if (note.type == NoteType.checklist) {
      listItemsCount = listItems.length + 1;
    }

    isLoading = false;
    notifyListeners();
  }

  /// Создание нового пункта в списке
  void createListItem() {
    /// Добавление нового объекта списка
    listItems.add(ListItem(text: '', checked: false));

    /// Добавление нового контроллера
    listItemControllers.add(TextEditingController());

    /// Пересчет количества пунктов
    listItemsCount = listItems.length + 1;

    notifyListeners();
  }

  /// Удаление пункта в списке
  void deleteListItem(int index) {
    /// Удаление объекта списка
    listItems.removeAt(index);

    /// Очистка и удаление контроллера
    listItemControllers[index].dispose();
    listItemControllers.removeAt(index);

    /// Пересчет количества пунктов
    listItemsCount = listItems.length + 1;

    notifyListeners();
  }

  /// Создание/обновление заметки
  void createOrUpdateNote() async {
    if (titleController.value.text.isEmpty) {
      DefaultToast.show('Название заметки не может быть пустым');
      return;
    }

    if (listItems.isNotEmpty) {
      for (var index = 0; index < listItems.length; index++) {
        listItems[index].text = listItemControllers[index].value.text;
      }
    }

    _note
      ..title = titleController.value.text
      ..contentText = contentController.value.text
      ..contentItems = listItems
      ..updated = needToUpdate ? DateTime.now() : _note.created;

    await noteRepository.createOrUpdateNote(_note);

    final int nid = _note.id.hashCode;

    await NotificationService.cancel(nid);

    if (_note.remindAt != null && _note.remindAt!.isAfter(DateTime.now())) {
      final notifOK = await NotificationService.areNotificationsEnabled();
      final alarmsOK = await NotificationService.areExactAlarmsPermitted();

      if (!notifOK || !alarmsOK) {
        await NotificationService.requestPermissions();
      }

      await NotificationService.schedule(
        id: nid,
        title: null,
        body: _note.title,
        at: _note.remindAt!,
        payload: _note.id,
      );
    }

    if (context.mounted) {
      openListPage(context);
    }
  }

  /// Удаление заметки
  void deleteNote() async {
    if (needToUpdate) {
      await noteRepository.deleteNote(_note.id);
    }

    if (context.mounted) {
      openListPage(context);
    }
  }

  /// Установка напоминания заметки
  void setReminder(DateTime? dateTime) {
    _note.remindAt = dateTime;

    notifyListeners();
  }

  /// Отмена напоминания заметки
  Future<void> removeReminder() async {
    final int nid = _note.id.hashCode;

    await NotificationService.cancel(nid);

    _note.remindAt = null;

    notifyListeners();
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
    context.pop(true);
  }
}
