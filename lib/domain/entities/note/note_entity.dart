import 'package:json_annotation/json_annotation.dart';

part 'note_entity.g.dart';

enum NoteType {
  text, // 0
  checklist, // 1
  audio, // 2
}

@JsonSerializable()
class ListItem {
  ListItem({
    required this.text,
    this.checked = false,
  });

  String text;
  bool checked;

  factory ListItem.fromJson(Map<String, dynamic> json) =>
      _$ListItemFromJson(json);

  Map<String, dynamic> toJson() => _$ListItemToJson(this);
}

@JsonSerializable()
class NoteEntity {
  NoteEntity({
    required this.id,
    required this.title,
    this.type = NoteType.text,
    this.contentText,
    this.contentItems,
    this.contentAudioPath,
    required this.created,
    required this.updated,
    this.pinned = false,
    this.remindAt,
    this.categoryId = '',
  });

  /// ID заметки
  final String id;

  /// ID категории
  @JsonKey(defaultValue: '')
  String categoryId;

  /// Закреплена ли заметка?
  @JsonKey(defaultValue: false)
  bool pinned;

  /// Дискриминатор
  @JsonKey(
    fromJson: _typeFromJson,
    toJson: _typeToJson,
    defaultValue: NoteType.text,
  )
  NoteType type;

  /// Заголовок заметки
  @JsonKey(defaultValue: '')
  String title;

  /// Контент для типа text
  @JsonKey(defaultValue: '')
  String? contentText;

  /// Контент для типа checklist
  @JsonKey(defaultValue: <ListItem>[])
  List<ListItem>? contentItems;

  /// Контент для типа audio
  String? contentAudioPath;

  /// Дата создания заметки
  final DateTime created;

  /// Дата последнего изменения заметки
  DateTime updated;

  /// Дата напоминания
  DateTime? remindAt;

  factory NoteEntity.fromJson(Map<String, dynamic> json) =>
      _$NoteEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NoteEntityToJson(this);

  /// Помощники для сериализации enum ↔ int
  static NoteType _typeFromJson(int code) =>
      NoteType.values.elementAt(code.clamp(0, NoteType.values.length - 1));

  static int _typeToJson(NoteType type) => type.index;

  /// Геттеры для UI
  bool get isText => type == NoteType.text;
  bool get isChecklist => type == NoteType.checklist;
  bool get isAudio => type == NoteType.audio;
}
