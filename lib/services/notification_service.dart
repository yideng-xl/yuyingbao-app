import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;

/// Service for scheduling and managing local notifications.
class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Initialize the notification plugin. Call once at app startup.
  Future<void> init() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(settings);
    _initialized = true;
  }

  /// Request notification permission (iOS 10+, Android 13+).
  Future<bool> requestPermission() async {
    // iOS
    final iosImpl = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (iosImpl != null) {
      final result = await iosImpl.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return result ?? false;
    }

    // Android 13+
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl != null) {
      final result = await androidImpl.requestNotificationsPermission();
      return result ?? false;
    }

    return true;
  }

  /// Schedule a feeding reminder notification after [intervalMinutes].
  ///
  /// Cancels any existing feeding reminder before scheduling a new one.
  Future<void> scheduleFeedingReminder({
    required int intervalMinutes,
    required String title,
    required String body,
  }) async {
    await cancelFeedingReminder();

    const androidDetails = AndroidNotificationDetails(
      'feeding_reminder',
      'Feeding Reminder',
      channelDescription: 'Reminds you to feed the baby',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final scheduledTime = tz.TZDateTime.now(tz.local)
        .add(Duration(minutes: intervalMinutes));

    await _plugin.zonedSchedule(
      _feedingReminderId,
      title,
      body,
      scheduledTime,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Cancel the feeding reminder notification.
  Future<void> cancelFeedingReminder() async {
    await _plugin.cancel(_feedingReminderId);
  }

  static const _feedingReminderId = 1001;
}
