import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../providers/tools_provider.dart';

class ToolsScreen extends ConsumerWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now().toUtc();

    return Scaffold(
      appBar: AppBar(title: const Text('Tools')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Konversi Waktu (selalu tampil real-time)
            _SectionHeader(
              title: 'Zona Waktu',
              subtitle: 'WIB · WITA · WIT · London',
              icon: Icons.access_time_rounded,
              color: AppTheme.primaryBlue,
              onTap: () => context.push(AppRoutes.timeZone),
            ),
            const SizedBox(height: 8),
            _TimeZoneCard(utcNow: now),

            const SizedBox(height: AppSpacing.md),

            // Section: Konversi Mata Uang
            _SectionHeader(
              title: 'Konversi Mata Uang',
              subtitle: 'IDR · USD · EUR · JPY · SGD',
              icon: Icons.currency_exchange_rounded,
              color: AppTheme.accentTeal,
              onTap: () => context.push(AppRoutes.currency),
            ),
            const SizedBox(height: 8),
            _CurrencyPreviewCard(),

            const SizedBox(height: AppSpacing.md),

            // Section: Kalkulator Tarif
            _SectionHeader(
              title: 'Kalkulator Tarif',
              subtitle: 'Estimasi biaya perjalanan',
              icon: Icons.calculate_outlined,
              color: AppTheme.warningAmber,
            ),
            const SizedBox(height: 8),
            _FareCalculatorCard(),

            const SizedBox(height: AppSpacing.md),

            // Section: Mini Game
            GestureDetector(
              onTap: () => context.push(AppRoutes.game),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.dangerCoral,
                      AppTheme.dangerCoral.withRed(180),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.sports_esports_rounded,
                        color: Colors.white, size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Route Planner Puzzle',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              )),
                          SizedBox(height: 4),
                          Text(
                            'Susun rute tercepat menggunakan berbagai moda transportasi!',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Section: Saran & Kesan
            GestureDetector(
              onTap: () => context.push(AppRoutes.feedback),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: Theme.of(context).dividerColor.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppTheme.safeGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.rate_review_outlined,
                          color: AppTheme.safeGreen),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Saran & Kesan',
                              style: Theme.of(context).textTheme.titleMedium),
                          Text('Mata Kuliah Teknologi Pemrograman Mobile',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        if (onTap != null)
          TextButton(
            onPressed: onTap,
            child: const Text('Buka'),
          ),
      ],
    );
  }
}

// ============================================================
// TIME ZONE CARD
// ============================================================

class _TimeZoneCard extends StatelessWidget {
  final DateTime utcNow;
  const _TimeZoneCard({required this.utcNow});

  @override
  Widget build(BuildContext context) {
    final zones = [
      {'label': 'WIB', 'offset': 7, 'city': 'Jakarta'},
      {'label': 'WITA', 'offset': 8, 'city': 'Bali'},
      {'label': 'WIT', 'offset': 9, 'city': 'Papua'},
      {'label': 'London', 'offset': 0, 'city': 'London'},
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: zones.map((z) {
            final localTime = utcNow.add(Duration(hours: z['offset'] as int));
            final timeStr = DateFormat('HH:mm').format(localTime);
            final dateStr = DateFormat('dd MMM').format(localTime);
            return Expanded(
              child: Column(
                children: [
                  Text(
                    timeStr,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.primaryBlue,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(z['label'] as String,
                      style: Theme.of(context).textTheme.labelLarge),
                  Text(z['city'] as String,
                      style: Theme.of(context).textTheme.bodySmall),
                  Text(dateStr,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ============================================================
// CURRENCY PREVIEW CARD
// ============================================================

class _CurrencyPreviewCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toolsState = ref.watch(toolsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text('1.000 IDR =', style: TextStyle(fontWeight: FontWeight.w500)),
                ),
                if (toolsState.isLoadingRates)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  TextButton(
                    onPressed: () =>
                        ref.read(toolsProvider.notifier).fetchRates(),
                    child: const Text('Perbarui Kurs'),
                  ),
              ],
            ),
            ...AppConstants.currencies
                .where((c) => c['code'] != 'IDR')
                .take(4)
                .map((c) {
              final rate = toolsState.rates[c['code']] ?? 0;
              final converted = rate * 1000;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Text(
                      '${c['symbol']} ',
                      style: TextStyle(
                          color: AppTheme.accentTeal,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(c['name'] ?? ''),
                    const Spacer(),
                    Text(
                      converted > 0
                          ? converted.toStringAsFixed(4)
                          : '-',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(' ${c['code']}',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// FARE CALCULATOR CARD
// ============================================================

class _FareCalculatorCard extends StatefulWidget {
  @override
  State<_FareCalculatorCard> createState() => _FareCalculatorCardState();
}

class _FareCalculatorCardState extends State<_FareCalculatorCard> {
  String _selectedMode = 'KRL';
  int _stations = 1;

  double get _fare {
    switch (_selectedMode) {
      case 'MRT': return 3000 + (_stations * 1000);
      case 'LRT': return 5000 + (_stations * 700);
      case 'Busway': return 3500;
      default: return 3000 + (_stations * 1000); // KRL
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedMode,
                    decoration: const InputDecoration(
                      labelText: 'Moda',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    items: ['KRL', 'MRT', 'LRT', 'Busway']
                        .map((m) =>
                            DropdownMenuItem(value: m, child: Text(m)))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedMode = v!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      Text('Jumlah Stasiun: $_stations',
                          style: Theme.of(context).textTheme.bodySmall),
                      Slider(
                        value: _stations.toDouble(),
                        min: 1,
                        max: 20,
                        divisions: 19,
                        onChanged: (v) =>
                            setState(() => _stations = v.round()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Estimasi Tarif:'),
                Text(
                  'Rp ${NumberFormat('#,###', 'id_ID').format(_fare)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.primaryBlue,
                        fontWeight: FontWeight.w700,
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

