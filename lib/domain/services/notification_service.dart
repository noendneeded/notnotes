import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notnotes/data/predefined/predefined_notifications.dart';
import 'package:notnotes/domain/dependencies/dependencies.dart';
import 'package:notnotes/domain/repositories/note_repository/i_note_repository.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static final StreamController<String> _clickController =
      StreamController<String>.broadcast();

  static Stream<String> get onNotificationClick => _clickController.stream;

  static Future<String?> getInitialNotificationPayload() async {
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp == true &&
        details?.notificationResponse?.payload != null) {
      return details!.notificationResponse!.payload;
    }
    return null;
  }

  /// Инициализация TZ и плагина уведомлений
  static Future<void> init() async {
    tz.initializeTimeZones();

    final offset = DateTime.now().timeZoneOffset;
    final hours = offset.inHours;

    // IANA-зоны в группе Etc используют обратный знак:
    // Etc/GMT-3 == UTC+3, Etc/GMT+5 == UTC-5

    final sign = hours >= 0 ? '-' : '+';
    final zoneName = 'Etc/GMT$sign${hours.abs()}';

    try {
      tz.setLocalLocation(tz.getLocation(zoneName));
    } catch (_) {
      tz.setLocalLocation(tz.UTC);
    }

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(
      const InitializationSettings(android: androidSettings),
    );

    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: (resp) async {
        final noteId = resp.payload;
        if (noteId == null) return;

        final repo = getIt<INoteRepository>();
        try {
          final note = await repo.getNoteById(noteId);
          note.remindAt = null;
          await repo.createOrUpdateNote(note);
        } catch (_) {}

        _clickController.add(noteId);
      },
    );
  }

  /// Запрос runtime‑прав (уведомления + exact alarms)
  static Future<bool?> requestPermissions() async {
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl == null) return null;

    // Показ уведомлений (Android 13+)
    final notifications = await androidImpl.requestNotificationsPermission();
    // Точные будильники (Android 12+)
    final exactAlarms = await androidImpl.requestExactAlarmsPermission();

    return notifications != null &&
        notifications &&
        exactAlarms != null &&
        exactAlarms;
  }

  /// Проверить, включены ли обычные уведомления (Android 13+)
  static Future<bool> areNotificationsEnabled() async {
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final enabled = await androidImpl?.areNotificationsEnabled();
    return enabled ?? true; // на iOS/Web считаем true
  }

  /// Проверить, разрешены ли точные будильники (Android 12+)
  static Future<bool> areExactAlarmsPermitted() async {
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final permitted = await androidImpl?.areNotificationsEnabled();
    return permitted ?? true;
  }

  /// Планирование уведомления
  static Future<void> schedule({
    required int id,
    String? title,
    required String body,
    required DateTime at,
    required String payload,
  }) {
    if (title == null || title.isEmpty) {
      final titles = kPredefinedNotificationTitles..shuffle();

      title = titles.first;
    }

    return _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(at, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'notes_channel',
          'Напоминания',
          channelDescription: 'Канал для напоминаний по заметкам',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          icon: 'ic_launcher',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  /// Отмена уведомления
  static Future<void> cancel(int id) => _plugin.cancel(id);
}
