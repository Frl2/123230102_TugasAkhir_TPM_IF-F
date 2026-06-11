// schedule_card.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/home_provider.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleModel schedule;
  const ScheduleCard({super.key, required this.schedule});

  Color get _transportColor {
    switch (schedule.transportType) {
      case 'MRT': return AppTheme.accentTeal;
      case 'LRT': return AppTheme.safeGreen;
      case 'Busway': return AppTheme.warningAmber;
      default: return AppTheme.primaryBlue; // KRL
    }
  }

  Color get _statusColor {
    switch (schedule.status) {
      case 'delayed': return AppTheme.warningAmber;
      case 'cancelled': return AppTheme.dangerCoral;
      default: return AppTheme.safeGreen;
    }
  }

  String get _statusLabel {
    switch (schedule.status) {
      case 'delayed': return 'Terlambat ${schedule.delayMinutes} menit';
      case 'cancelled': return 'Dibatalkan';
      default: return 'Tepat Waktu';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Transport Badge
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _transportColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                schedule.transportType == 'Busway'
                    ? Icons.directions_bus_rounded
                    : Icons.train_rounded,
                color: _transportColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    schedule.trainName,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 12,
                          color: Theme.of(context).textTheme.bodySmall?.color),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          '${schedule.origin} → ${schedule.destination}',
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _buildTag(schedule.platform, Colors.grey),
                      const SizedBox(width: 6),
                      _buildTag(_statusLabel, _statusColor),
                      const SizedBox(width: 6),
                      _buildCrowdTag(schedule.crowdLevel),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Departure Time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  schedule.departureTime,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: _transportColor,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Icon(Icons.notifications_none_rounded,
                    size: 18,
                    color: Theme.of(context).textTheme.bodySmall?.color),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCrowdTag(int level) {
    final colors = [
      Colors.green, Colors.lightGreen, Colors.orange, Colors.deepOrange, Colors.red
    ];
    final labels = ['Sepi', 'Longgar', 'Normal', 'Padat', 'Penuh'];
    final color = colors[level.clamp(1, 5) - 1];
    return _buildTag(labels[level.clamp(1, 5) - 1], color);
  }
}
