import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_compass/flutter_compass.dart';

import '../constants/app_constants.dart';
import 'notification_service.dart';

// ============================================================
// DATA MODELS
// ============================================================

class AccelerometerData {
  final double x;
  final double y;
  final double z;
  final double magnitude;
  final DateTime timestamp;

  const AccelerometerData({
    required this.x,
    required this.y,
    required this.z,
    required this.magnitude,
    required this.timestamp,
  });

  factory AccelerometerData.fromEvent(AccelerometerEvent event) {
    final mag = sqrt(
      event.x * event.x + event.y * event.y + event.z * event.z,
    );
    return AccelerometerData(
      x: event.x,
      y: event.y,
      z: event.z,
      magnitude: mag,
      timestamp: DateTime.now(),
    );
  }

  bool get isCrash => magnitude >= AppConstants.accelCrashThreshold;
  bool get isFall => magnitude >= AppConstants.accelFallThreshold && magnitude < AppConstants.accelCrashThreshold;
  bool get isNormal => magnitude < AppConstants.accelFallThreshold;

  String get statusLabel {
    if (isCrash) return 'BENTURAN KERAS';
    if (isFall) return 'JATUH TERDETEKSI';
    return 'Normal';
  }
}

class CompassData {
  final double heading; // derajat 0-360
  final double? accuracy;

  const CompassData({required this.heading, this.accuracy});

  String get cardinalDirection {
    if (heading >= 337.5 || heading < 22.5) return 'Utara';
    if (heading < 67.5) return 'Timur Laut';
    if (heading < 112.5) return 'Timur';
    if (heading < 157.5) return 'Tenggara';
    if (heading < 202.5) return 'Selatan';
    if (heading < 247.5) return 'Barat Daya';
    if (heading < 292.5) return 'Barat';
    return 'Barat Laut';
  }

  String get cardinalShort {
    if (heading >= 337.5 || heading < 22.5) return 'U';
    if (heading < 67.5) return 'TL';
    if (heading < 112.5) return 'T';
    if (heading < 157.5) return 'TG';
    if (heading < 202.5) return 'S';
    if (heading < 247.5) return 'BD';
    if (heading < 292.5) return 'B';
    return 'BL';
  }
}

// ============================================================
// SENSOR SERVICE
// ============================================================

class SensorService {
  StreamSubscription<AccelerometerEvent>? _accelSubscription;
  StreamSubscription<CompassEvent>? _compassSubscription;

  final _accelController = StreamController<AccelerometerData>.broadcast();
  final _compassController = StreamController<CompassData>.broadcast();
  final _incidentController = StreamController<AccelerometerData>.broadcast();

  Stream<AccelerometerData> get accelerometerStream => _accelController.stream;
  Stream<CompassData> get compassStream => _compassController.stream;
  Stream<AccelerometerData> get incidentStream => _incidentController.stream;

  AccelerometerData? _lastData;
  DateTime? _lastIncidentTime;
  bool _isMonitoring = false;

  static const Duration _incidentCooldown = Duration(seconds: 10);

  void startMonitoring() {
    if (_isMonitoring) return;
    _isMonitoring = true;

    // Accelerometer stream
    _accelSubscription = accelerometerEventStream(
      samplingPeriod: SensorInterval.normalInterval,
    ).listen((event) {
      final data = AccelerometerData.fromEvent(event);
      _lastData = data;
      _accelController.add(data);

      // Deteksi insiden
      _detectIncident(data);
    });

    // Compass stream (Magnetometer)
    _compassSubscription = FlutterCompass.events?.listen((event) {
      if (event.heading != null) {
        final compassData = CompassData(
          heading: event.heading!,
          accuracy: event.accuracy,
        );
        _compassController.add(compassData);
      }
    });
  }

  void _detectIncident(AccelerometerData data) {
    if (data.isNormal) return;

    // Cooldown untuk mencegah spam notifikasi
    if (_lastIncidentTime != null &&
        DateTime.now().difference(_lastIncidentTime!) < _incidentCooldown) {
      return;
    }

    _lastIncidentTime = DateTime.now();
    _incidentController.add(data);

    // Kirim notifikasi darurat
    if (data.isCrash) {
      NotificationService.showIncidentAlert(
        title: '⚠️ Benturan Keras Terdeteksi!',
        body: 'Percepatan: ${data.magnitude.toStringAsFixed(1)} m/s². Apakah Anda baik-baik saja?',
      );
    } else if (data.isFall) {
      NotificationService.showIncidentAlert(
        title: '⚠️ Kemungkinan Terjatuh',
        body: 'Gerakan tidak biasa terdeteksi. Apakah Anda membutuhkan bantuan?',
      );
    }
  }

  void stopMonitoring() {
    _accelSubscription?.cancel();
    _compassSubscription?.cancel();
    _isMonitoring = false;
  }

  AccelerometerData? get latestAccelData => _lastData;
  bool get isMonitoring => _isMonitoring;

  void dispose() {
    stopMonitoring();
    _accelController.close();
    _compassController.close();
    _incidentController.close();
  }

  static Future initialize() async {
    // Cek apakah sensor tersedia
    // Dijalankan di main()
  }
}

// ============================================================
// PROVIDERS
// ============================================================

final sensorServiceProvider = Provider<SensorService>((ref) {
  final service = SensorService();
  ref.onDispose(() => service.dispose());
  return service;
});

final accelerometerProvider = StreamProvider<AccelerometerData>((ref) {
  final service = ref.watch(sensorServiceProvider);
  service.startMonitoring();
  return service.accelerometerStream;
});

final compassProvider = StreamProvider<CompassData>((ref) {
  final service = ref.watch(sensorServiceProvider);
  return service.compassStream;
});

final incidentProvider = StreamProvider<AccelerometerData>((ref) {
  final service = ref.watch(sensorServiceProvider);
  return service.incidentStream;
});
