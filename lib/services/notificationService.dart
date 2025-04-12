import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> init() async {
    // Initialiser les fuseaux horaires
    tz.initializeTimeZones();

    // Paramètres d'initialisation pour Android
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // Paramètres d'initialisation pour iOS
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();

    // Paramètres d'initialisation globaux
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Initialisation
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );
  }

  void _onNotificationResponse(NotificationResponse response) {
    // Gérer les clics sur la notification ici
    print("Notification clicked with payload: ${response.payload}");
    // Exemple : redirection vers une page spécifique
    // if (response.payload != null) {
    //   Navigator.of(context).pushNamed('/details', arguments: response.payload);
    // }
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? imagePath,
  }) async {
    try {
      // Initialiser les fuseaux horaires
      tz.initializeTimeZones();
      final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
      final location = tz.getLocation(currentTimeZone);
      tz.setLocalLocation(location);
      final scheduledTimeTz = tz.TZDateTime.from(scheduledTime, location);

      // Préparer les détails Android avec ou sans image
      final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'channel_id',
        'A Faire',
        channelDescription: 'Canal pour les rappels des tâches',
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: imagePath != null
            ? BigPictureStyleInformation(
          FilePathAndroidBitmap(imagePath),
          contentTitle: title,
          summaryText: body,
        )
            : null,
      );

      // Détails globaux de la notification
      final NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

      // Programmer la notification
      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledTimeTz,
        notificationDetails,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (e) {
      print('Erreur lors de la programmation de la notification : $e');
    }
  }



  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }


}
