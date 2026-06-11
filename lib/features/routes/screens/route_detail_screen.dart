import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../providers/route_provider.dart';
import '../../../core/theme/app_theme.dart';

class RouteDetailScreen extends ConsumerWidget {
  final String routeId;
  const RouteDetailScreen({super.key, required this.routeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeState = ref.watch(routeProvider);
    final route = routeState.routes.cast<RouteModel?>().firstWhere(
          (r) => r?.id == routeId,
          orElse: () => routeState.routes.isNotEmpty
              ? routeState.routes.first
              : null,
        );

    if (route == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Rute')),
        body: const Center(child: Text('Rute tidak ditemukan')),
      );
    }

    final isRecommended = routeState.routes.isNotEmpty && routeState.routes.first.id == route.id;
    final currFmt = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '${route.origin} → ${route.destination}',
                style: const TextStyle(fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppTheme.primaryBlue, AppTheme.accentTeal],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 60, 16, 40),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      if (isRecommended)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('★ Direkomendasikan',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87)),
                        ),
                      ...route.transportModes.map((m) => _TransportBadge(mode: m)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          _SummaryItem(
                              Icons.access_time_rounded,
                              '${route.estimatedMinutes} menit',
                              'Durasi'),
                          _divider(),
                          _SummaryItem(
                              Icons.transfer_within_a_station_rounded,
                              '${route.transfers} kali',
                              'Transfer'),
                          _divider(),
                          _SummaryItem(
                              _crowdIcon(route.crowdScore),
                              _crowdLabel(route.crowdScore),
                              'Kepadatan',
                              color: _crowdColor(route.crowdScore)),
                          _divider(),
                          _SummaryItem(
                              Icons.payments_outlined,
                              currFmt.format(route.fareIdr),
                              'Tarif'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Steps Timeline
                  Text('Langkah Perjalanan',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _TimelineStep(
                            label: route.origin,
                            subtitle: 'Titik Keberangkatan',
                            isFirst: true,
                            isLast: false,
                          ),
                          ...route.steps.map((step) => _TimelineStep(
                                label: step.toStation,
                                subtitle:
                                    '${step.instruction} (${step.durationMinutes} mnt)',
                                isFirst: false,
                                isLast: step == route.steps.last,
                                transportType: step.transportType,
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Crowd forecast bar chart
                  Text('Prediksi Kepadatan',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  _CrowdBarChart(),
                  const SizedBox(height: 16),

                  // Safety tips
                  Text('Tips Keamanan',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  _SafetyTipsCard(),
                  const SizedBox(height: 24),

                  // CTA
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Navigasi dimulai — ikuti petunjuk rute'),
                          backgroundColor: AppTheme.safeGreen,
                        ),
                      ),
                      icon: const Icon(Icons.navigation_rounded),
                      label: const Text('Mulai Navigasi'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Container(height: 40, width: 1, color: Colors.grey[200]);

  IconData _crowdIcon(double score) {
    if (score > 3.5) return Icons.people_alt_rounded;
    if (score > 2) return Icons.people_outline_rounded;
    return Icons.person_outline_rounded;
  }

  String _crowdLabel(double score) {
    if (score > 4) return 'Sangat Padat';
    if (score > 3) return 'Padat';
    if (score > 2) return 'Normal';
    if (score > 1) return 'Sepi';
    return 'Sangat Sepi';
  }

  Color _crowdColor(double score) {
    if (score > 3.5) return Colors.red;
    if (score > 2.5) return Colors.orange;
    return Colors.green;
  }
}

class _TransportBadge extends StatelessWidget {
  final String mode;
  const _TransportBadge({required this.mode});

  Color get color {
    switch (mode) {
      case 'MRT': return AppTheme.accentTeal;
      case 'Busway': return AppTheme.warningAmber;
      case 'Jalan Kaki': return Colors.grey;
      default: return AppTheme.primaryBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(mode,
          style: const TextStyle(
              color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? color;

  const _SummaryItem(this.icon, this.value, this.label, {this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color ?? AppTheme.primaryBlue, size: 22),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              textAlign: TextAlign.center),
          Text(label,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  final String label;
  final String subtitle;
  final bool isFirst;
  final bool isLast;
  final String? transportType;

  const _TimelineStep({
    required this.label,
    required this.subtitle,
    required this.isFirst,
    required this.isLast,
    this.transportType,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: isFirst || isLast
                        ? AppTheme.primaryBlue
                        : Colors.grey[300],
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppTheme.primaryBlue,
                        width: isFirst || isLast ? 0 : 2),
                  ),
                ),
                if (!isLast)
                  Expanded(child: Container(width: 2, color: Colors.grey[300])),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          fontWeight: isFirst || isLast
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 14)),
                  Text(subtitle,
                      style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CrowdBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hours = ['06', '08', '10', '12', '14', '16', '18', '20'];
    final levels = [0.3, 0.9, 0.5, 0.4, 0.4, 0.7, 0.95, 0.6];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(hours.length, (i) {
                final pct = levels[i];
                final color = pct > 0.7
                    ? Colors.red
                    : pct > 0.5
                        ? Colors.orange
                        : Colors.green;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      children: [
                        Container(
                          height: 60 * pct,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(hours[i],
                            style: const TextStyle(
                                fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _legend(Colors.green, 'Sepi'),
                const SizedBox(width: 16),
                _legend(Colors.orange, 'Sedang'),
                const SizedBox(width: 16),
                _legend(Colors.red, 'Padat'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _legend(Color color, String label) => Row(
        children: [
          Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: color, shape: BoxShape.circle)),
          const SizedBox(width: 4),
          Text(label,
              style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      );
}

class _SafetyTipsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tips = [
      'Selalu perhatikan barang bawaan Anda di kerumunan',
      'Gunakan jalur resmi dan ikuti petunjuk petugas',
      'Laporkan kejadian mencurigakan ke petugas keamanan',
      'Hindari menggunakan ponsel saat berjalan di peron',
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: tips
              .map((tip) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline,
                            size: 16, color: AppTheme.safeGreen),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(tip,
                                style: const TextStyle(fontSize: 13))),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
