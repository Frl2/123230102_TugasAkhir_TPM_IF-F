import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class TimeConverterScreen extends StatefulWidget {
  const TimeConverterScreen({super.key});

  @override
  State<TimeConverterScreen> createState() => _TimeConverterScreenState();
}

class _TimeConverterScreenState extends State<TimeConverterScreen> {
  late Timer _timer;
  DateTime _utcNow = DateTime.now().toUtc();

  // Custom time input
  TimeOfDay? _customTime;
  String _fromZone = 'WIB';

  @override
  void initState() {
    super.initState();
    // Update setiap detik
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _utcNow = DateTime.now().toUtc());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  DateTime _getLocalTime(int offsetHours) =>
      _utcNow.add(Duration(hours: offsetHours));

  DateTime _convertCustomTime(TimeOfDay time, String fromZone, String toZone) {
    final fromOffset = AppConstants.timeZones[fromZone] ?? 7;
    final toOffset = AppConstants.timeZones[toZone] ?? 7;
    final baseUtc = DateTime.utc(2024, 1, 1, time.hour, time.minute)
        .subtract(Duration(hours: fromOffset));
    return baseUtc.add(Duration(hours: toOffset));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konversi Zona Waktu')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live clocks
            Text('Waktu Saat Ini (Live)',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.4,
              children: AppConstants.timeZones.entries.map((e) {
                final localTime = _getLocalTime(e.value);
                return _ClockCard(
                  zone: e.key,
                  offset: e.value,
                  localTime: localTime,
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Custom time converter
            Text('Konversi Waktu Kustom',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Waktu Input',
                                  style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 4),
                              OutlinedButton.icon(
                                onPressed: () async {
                                  final picked = await showTimePicker(
                                    context: context,
                                    initialTime: _customTime ??
                                        TimeOfDay.fromDateTime(_utcNow.add(
                                          const Duration(hours: 7),
                                        )),
                                  );
                                  if (picked != null) {
                                    setState(() => _customTime = picked);
                                  }
                                },
                                icon: const Icon(Icons.access_time_rounded, size: 16),
                                label: Text(
                                  _customTime != null
                                      ? _customTime!.format(context)
                                      : 'Pilih Waktu',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Zona Asal',
                                  style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 4),
                              DropdownButtonFormField<String>(
                                value: _fromZone,
                                decoration: const InputDecoration(isDense: true),
                                items: AppConstants.timeZones.keys
                                    .map((z) => DropdownMenuItem(
                                          value: z,
                                          child: Text(z),
                                        ))
                                    .toList(),
                                onChanged: (v) =>
                                    setState(() => _fromZone = v!),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    if (_customTime != null) ...[
                      const Divider(height: 24),
                      Text('Hasil Konversi',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      ...AppConstants.timeZones.keys
                          .where((z) => z != _fromZone)
                          .map((toZone) {
                        final converted = _convertCustomTime(
                            _customTime!, _fromZone, toZone);
                        final timeStr = DateFormat('HH:mm').format(converted);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              Container(
                                width: 52,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color:
                                      AppTheme.primaryBlue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  toZone,
                                  style: TextStyle(
                                    color: AppTheme.primaryBlue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                timeStr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const Spacer(),
                              Text(
                                'UTC+${AppConstants.timeZones[toZone]}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Info zona waktu Indonesia
            Text('Info Zona Waktu',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  _InfoRow('WIB', 'UTC+7', 'Jawa, Sumatera, Kalimantan Barat & Tengah'),
                  const Divider(height: 1),
                  _InfoRow('WITA', 'UTC+8', 'Bali, NTT, NTB, Kalimantan Timur & Selatan, Sulawesi'),
                  const Divider(height: 1),
                  _InfoRow('WIT', 'UTC+9', 'Papua, Maluku, Maluku Utara'),
                  const Divider(height: 1),
                  _InfoRow('London', 'UTC+0', 'London (BST: UTC+1 saat musim panas)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClockCard extends StatelessWidget {
  final String zone;
  final int offset;
  final DateTime localTime;

  const _ClockCard({
    required this.zone,
    required this.offset,
    required this.localTime,
  });

  Color get _color {
    switch (zone) {
      case 'WIB': return AppTheme.primaryBlue;
      case 'WITA': return AppTheme.accentTeal;
      case 'WIT': return AppTheme.warningAmber;
      default: return AppTheme.neutralGray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  zone,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'UTC+$offset',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const Spacer(),
          Text(
            DateFormat('HH:mm:ss').format(localTime),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _color,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          Text(
            DateFormat('EEE, dd MMM yyyy', 'id_ID').format(localTime),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String zone, utc, desc;
  const _InfoRow(this.zone, this.utc, this.desc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(zone,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            width: 55,
            child: Text(utc,
                style: TextStyle(color: AppTheme.primaryBlue, fontSize: 12)),
          ),
          Expanded(
            child: Text(desc,
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
