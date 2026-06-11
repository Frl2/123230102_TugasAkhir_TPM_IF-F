import 'dart:ui' show Color;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const int _incidentChannelId = 1;
  static const int _scheduleChannelId = 2;
  static const int _crowdChannelId = 3;
  static const int _routeChannelId = 4;

  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
    );

    // Buat channel Android
    await _createChannels();
  }

  static Future<void> _createChannels() async {
    const incidentChannel = AndroidNotificationChannel(
      'incident_channel',
      'Peringatan Darurat',
      description: 'Notifikasi untuk insiden dan kecelakaan',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );
    const scheduleChannel = AndroidNotificationChannel(
      'schedule_channel',
      'Jadwal Transportasi',
      description: 'Pengingat jadwal keberangkatan',
      importance: Importance.high,
    );
    const crowdChannel = AndroidNotificationChannel(
      'crowd_channel',
      'Info Kepadatan',
      description: 'Notifikasi tingkat kepadatan gerbong',
      importance: Importance.defaultImportance,
    );
    const routeChannel = AndroidNotificationChannel(
      'route_channel',
      'Informasi Rute',
      description: 'Update rute dan gangguan transportasi',
      importance: Importance.high,
    );

    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(incidentChannel);
    await androidPlugin?.createNotificationChannel(scheduleChannel);
    await androidPlugin?.createNotificationChannel(crowdChannel);
    await androidPlugin?.createNotificationChannel(routeChannel);
  }

  // Incident / Emergency Alert
  static Future<void> showIncidentAlert({
    required String title,
    required String body,
  }) async {
    await _plugin.show(
      _incidentChannelId,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'incident_channel',
          'Peringatan Darurat',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          color: Color.fromARGB(255, 216, 67, 21),
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  // Jadwal Transport
  static Future<void> showScheduleReminder({
    required String trainName,
    required String station,
    required String time,
  }) async {
    await _plugin.show(
      _scheduleChannelId,
      '🚆 $trainName berangkat $time',
      'Dari Stasiun $station — Segera menuju peron!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'schedule_channel',
          'Jadwal Transportasi',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  // Crowd Alert
  static Future<void> showCrowdAlert({
    required String stationName,
    required int crowdLevel,
  }) async {
    final labels = {1: 'Sangat Sepi', 2: 'Sepi', 3: 'Normal', 4: 'Padat', 5: 'Sangat Padat'};
    final emojis = {1: '😊', 2: '🙂', 3: '😐', 4: '😟', 5: '😱'};
    await _plugin.show(
      _crowdChannelId,
      '${emojis[crowdLevel]} Kepadatan $stationName: ${labels[crowdLevel]}',
      'Prediksi kepadatan saat ini di stasiun tersebut.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'crowd_channel',
          'Info Kepadatan',
        ),
      ),
    );
  }

  // Route Disruption
  static Future<void> showRouteDisruption({
    required String line,
    required String message,
  }) async {
    await _plugin.show(
      _routeChannelId,
      '⚠️ Gangguan $line',
      message,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'route_channel',
          'Informasi Rute',
          importance: Importance.high,
        ),
      ),
    );
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
