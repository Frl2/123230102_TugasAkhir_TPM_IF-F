import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class CrowdIndicator extends StatelessWidget {
  final String stationName;
  final int level; // 1-5
  final String transportType;
  final String predictedTime;

  const CrowdIndicator({
    super.key,
    required this.stationName,
    required this.level,
    required this.transportType,
    required this.predictedTime,
  });

  Color get _levelColor {
    switch (level) {
      case 1: return const Color(0xFF2E7D32);
      case 2: return const Color(0xFF558B2F);
      case 3: return const Color(0xFFF9A825);
      case 4: return const Color(0xFFE65100);
      case 5: return const Color(0xFFC62828);
      default: return Colors.grey;
    }
  }

  String get _levelLabel => AppConstants.crowdLabels[level] ?? 'Normal';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _levelColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: _levelColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          // Level indicator
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _levelColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                level.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stationName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      _levelLabel,
                      style: TextStyle(
                        color: _levelColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '  ·  $predictedTime',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Progress bar level
          SizedBox(
            width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transportType,
                  style: TextStyle(
                    fontSize: 10,
                    color: _levelColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: level / 5,
                  backgroundColor: _levelColor.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(_levelColor),
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

