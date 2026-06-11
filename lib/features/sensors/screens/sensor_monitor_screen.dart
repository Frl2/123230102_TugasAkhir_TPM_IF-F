import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/sensor_service.dart';
import '../../../core/theme/app_theme.dart';

class SensorMonitorScreen extends ConsumerWidget {
  const SensorMonitorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accelAsync = ref.watch(accelerometerProvider);
    final compassAsync = ref.watch(compassProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitor Sensor'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.safeGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.safeGreen.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppTheme.safeGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Aktif',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.safeGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Accelerometer Section
            Text('Accelerometer',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              'Mendeteksi benturan keras dan jatuh',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),

            accelAsync.when(
              data: (data) => _AccelerometerCard(data: data),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => _ErrorCard(
                message: 'Accelerometer tidak tersedia: $e',
              ),
            ),

            const SizedBox(height: 24),

            // Magnetometer / Compass Section
            Text('Magnetometer (Kompas)',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              'Navigasi indoor di stasiun bawah tanah',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),

            compassAsync.when(
              data: (data) => _CompassCard(data: data),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => _ErrorCard(
                message: 'Magnetometer tidak tersedia: $e',
              ),
            ),

            const SizedBox(height: 24),

            // Incident history
            _IncidentHistorySection(),
          ],
        ),
      ),
    );
  }
}

class _AccelerometerCard extends StatelessWidget {
  final AccelerometerData data;
  const _AccelerometerCard({required this.data});

  Color get _statusColor {
    if (data.isCrash) return AppTheme.dangerCoral;
    if (data.isFall) return AppTheme.warningAmber;
    return AppTheme.safeGreen;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Status banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: _statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _statusColor.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    data.isCrash
                        ? Icons.warning_rounded
                        : data.isFall
                            ? Icons.person_off_rounded
                            : Icons.check_circle_outline_rounded,
                    color: _statusColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    data.statusLabel,
                    style: TextStyle(
                      color: _statusColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Magnitude gauge
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Besaran (m/s²)',
                              style: TextStyle(fontSize: 12)),
                          Text(
                            data.magnitude.toStringAsFixed(2),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: _statusColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: (data.magnitude / 25).clamp(0.0, 1.0),
                        backgroundColor: Colors.grey.shade200,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(_statusColor),
                        borderRadius: BorderRadius.circular(4),
                        minHeight: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 12),

            // Axis values
            Row(
              children: [
                _AxisCard(label: 'X', value: data.x, color: Colors.red),
                const SizedBox(width: 8),
                _AxisCard(label: 'Y', value: data.y, color: Colors.green),
                const SizedBox(width: 8),
                _AxisCard(label: 'Z', value: data.z, color: AppTheme.primaryBlue),
              ],
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.info_outline_rounded, size: 12, color: Colors.grey.shade500),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Threshold benturan: ≥${AppConstants.accelCrashThreshold} m/s²  |  Jatuh: ≥${AppConstants.accelFallThreshold} m/s²',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppConstants {
  static const double accelCrashThreshold = 20.0;
  static const double accelFallThreshold = 15.0;
}

class _AxisCard extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _AxisCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompassCard extends StatelessWidget {
  final CompassData data;
  const _CompassCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // Compass dial
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CustomPaint(
                    painter: _CompassPainter(heading: data.heading),
                    child: Center(
                      child: Transform.rotate(
                        angle: -data.heading * 3.14159 / 180,
                        child: const Icon(
                          Icons.navigation_rounded,
                          color: AppTheme.dangerCoral,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data.heading.toStringAsFixed(1)}°',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: AppTheme.primaryBlue,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.cardinalDirection,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        data.cardinalShort,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                      if (data.accuracy != null)
                        Text(
                          'Akurasi: ±${data.accuracy!.toStringAsFixed(1)}°',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.subway_rounded, size: 14, color: AppTheme.primaryBlue),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Kompas aktif untuk navigasi indoor stasiun bawah tanah',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  final double heading;
  _CompassPainter({required this.heading});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final bgPaint = Paint()
      ..color = const Color(0xFFF0F4F8)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius - 2, bgPaint);

    final borderPaint = Paint()
      ..color = const Color(0xFFCDD5DF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius - 2, borderPaint);

    final tickPaint = Paint()
      ..color = const Color(0xFF546E7A)
      ..strokeWidth = 1;

    for (int i = 0; i < 360; i += 30) {
      final angle = i * 3.14159 / 180;
      final outerPoint = Offset(
        center.dx + (radius - 6) * Math.sin(angle),
        center.dy - (radius - 6) * Math.cos(angle),
      );
      final innerPoint = Offset(
        center.dx + (radius - 14) * Math.sin(angle),
        center.dy - (radius - 14) * Math.cos(angle),
      );
      canvas.drawLine(outerPoint, innerPoint, tickPaint);
    }
  }

  @override
  bool shouldRepaint(_CompassPainter old) => old.heading != heading;
}

// Math helper
class Math {
  static double sin(double x) => (x - x * x * x / 6 + x * x * x * x * x / 120);
  static double cos(double x) => (1 - x * x / 2 + x * x * x * x / 24);
}

class _IncidentHistorySection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incidentAsync = ref.watch(incidentProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Riwayat Insiden Terdeteksi',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        incidentAsync.when(
          data: (incident) => Card(
            child: ListTile(
              leading: const Icon(Icons.warning_rounded,
                  color: AppTheme.warningAmber),
              title: Text(incident.statusLabel),
              subtitle: Text(
                'Besaran: ${incident.magnitude.toStringAsFixed(2)} m/s²\n'
                '${incident.timestamp.toString().substring(0, 19)}',
              ),
            ),
          ),
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).dividerColor.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Colors.grey.shade500),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Jika insiden terdeteksi, notifikasi darurat otomatis dikirim. '
                  'Sensor aktif selama aplikasi berjalan.',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String message;
  const _ErrorCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.dangerCoral.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.dangerCoral.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppTheme.dangerCoral, size: 18),
          const SizedBox(width: 8),
          Expanded(
              child: Text(message, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
