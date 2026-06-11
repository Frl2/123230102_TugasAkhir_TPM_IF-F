import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../providers/route_provider.dart';

class RouteSearchScreen extends ConsumerStatefulWidget {
  const RouteSearchScreen({super.key});

  @override
  ConsumerState<RouteSearchScreen> createState() => _RouteSearchScreenState();
}

class _RouteSearchScreenState extends ConsumerState<RouteSearchScreen>
    with SingleTickerProviderStateMixin {
  final _originCtrl = TextEditingController();
  final _destCtrl = TextEditingController();
  late TabController _tabController;
  bool _showLlmChat = false;
  final _chatCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _originCtrl.dispose();
    _destCtrl.dispose();
    _chatCtrl.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _searchRoute() async {
    if (_originCtrl.text.isEmpty || _destCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Isi asal dan tujuan terlebih dahulu')),
      );
      return;
    }
    await ref.read(routeProvider.notifier).searchRoute(
          origin: _originCtrl.text.trim(),
          destination: _destCtrl.text.trim(),
        );
  }

  Future<void> _askLlm() async {
    if (_chatCtrl.text.isEmpty) return;
    final question = _chatCtrl.text.trim();
    _chatCtrl.clear();
    await ref.read(routeProvider.notifier).askLlmAssistant(question);
  }

  @override
  Widget build(BuildContext context) {
    final routeState = ref.watch(routeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Rute'),
        actions: [
          IconButton(
            onPressed: () => setState(() => _showLlmChat = !_showLlmChat),
            icon: Icon(
              Icons.smart_toy_rounded,
              color: _showLlmChat ? AppTheme.primaryBlue : null,
            ),
            tooltip: 'Asisten AI Rute',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Cari Rute'),
            Tab(text: 'Favorit'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1: Search
          Column(
            children: [
              // Input form
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _originCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Dari (stasiun/halte asal)',
                        prefixIcon: Icon(Icons.radio_button_checked_rounded,
                            color: AppTheme.safeGreen),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Swap button
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          final tmp = _originCtrl.text;
                          _originCtrl.text = _destCtrl.text;
                          _destCtrl.text = tmp;
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.swap_vert_rounded, size: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _destCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Ke (stasiun/halte tujuan)',
                        prefixIcon: Icon(Icons.location_on_rounded,
                            color: AppTheme.dangerCoral),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: routeState.isLoading ? null : _searchRoute,
                        icon: const Icon(Icons.search_rounded, size: 18),
                        label: routeState.isLoading
                            ? const Text('Mencari...')
                            : const Text('Cari Rute Terbaik'),
                      ),
                    ),
                  ],
                ),
              ),

              // LLM Chat Panel
              if (_showLlmChat)
                _buildLlmPanel(routeState),

              const Divider(height: 1),

              // Results
              Expanded(
                child: routeState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : routeState.routes.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            itemCount: routeState.routes.length,
                            itemBuilder: (context, index) {
                              final route = routeState.routes[index];
                              return _RouteCard(
                                route: route,
                                isRecommended: index == 0,
                                onTap: () => context.push('/routes/${route.id}'),
                              );
                            },
                          ),
              ),
            ],
          ),

          // TAB 2: Favorites
          const _FavoriteRoutesTab(),
        ],
      ),
    );
  }

  Widget _buildLlmPanel(RouteState routeState) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue.withOpacity(0.05),
        border: Border(
          bottom: BorderSide(
            color: AppTheme.primaryBlue.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: AppTheme.primaryBlue.withOpacity(0.1),
            child: Row(
              children: [
                const Icon(Icons.smart_toy_rounded,
                    size: 16, color: AppTheme.primaryBlue),
                const SizedBox(width: 6),
                Text(
                  'Asisten Rute AI (LLM)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryBlue,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: routeState.llmMessages.length,
              itemBuilder: (context, index) {
                final msg = routeState.llmMessages[index];
                final isUser = msg['role'] == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isUser
                          ? AppTheme.primaryBlue
                          : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      msg['content'] ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: isUser ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Tanya rute alternatif...',
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      isDense: true,
                    ),
                    onSubmitted: (_) => _askLlm(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _askLlm,
                  icon: const Icon(Icons.send_rounded, size: 20),
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.route_outlined,
              size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Cari rute perjalananmu',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Masukkan stasiun asal dan tujuan\nuntuk menemukan rute terbaik',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _RouteCard extends StatelessWidget {
  final RouteModel route;
  final bool isRecommended;
  final VoidCallback onTap;

  const _RouteCard({
    required this.route,
    required this.isRecommended,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: isRecommended
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(
                  color: AppTheme.primaryBlue, width: 1.5),
            )
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (isRecommended)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Direkomendasikan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  Text(
                    '${route.estimatedMinutes} menit',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.primaryBlue,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    'Rp ${route.fareIdr.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Transport modes
              Wrap(
                spacing: 6,
                children: route.transportModes
                    .map((mode) => _TransportChip(mode: mode))
                    .toList(),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.people_outline_rounded,
                      size: 14,
                      color: Theme.of(context).textTheme.bodySmall?.color),
                  const SizedBox(width: 4),
                  Text(
                    'Kepadatan: ${_crowdLabel(route.crowdScore)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  Text(
                    '${route.transfers} kali transit',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _crowdLabel(double score) {
    if (score <= 1.5) return 'Sangat Sepi';
    if (score <= 2.5) return 'Sepi';
    if (score <= 3.5) return 'Normal';
    if (score <= 4.5) return 'Padat';
    return 'Sangat Padat';
  }
}

class _TransportChip extends StatelessWidget {
  final String mode;
  const _TransportChip({required this.mode});

  Color get _color {
    switch (mode) {
      case 'MRT': return AppTheme.accentTeal;
      case 'LRT': return AppTheme.safeGreen;
      case 'Busway': return AppTheme.warningAmber;
      case 'Jalan Kaki': return Colors.grey;
      default: return AppTheme.primaryBlue;
    }
  }

  IconData get _icon {
    switch (mode) {
      case 'Busway': return Icons.directions_bus_rounded;
      case 'Jalan Kaki': return Icons.directions_walk_rounded;
      default: return Icons.train_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, size: 12, color: _color),
          const SizedBox(width: 4),
          Text(mode, style: TextStyle(fontSize: 11, color: _color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _FavoriteRoutesTab extends ConsumerWidget {
  const _FavoriteRoutesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(routeProvider);
    if (state.favoriteRoutes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_border_rounded, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            const Text('Belum ada rute favorit'),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: state.favoriteRoutes.length,
      itemBuilder: (context, index) {
        final fav = state.favoriteRoutes[index];
        return ListTile(
          leading: const Icon(Icons.bookmark_rounded, color: AppTheme.primaryBlue),
          title: Text(fav['name'] ?? ''),
          subtitle: Text('${fav['origin']} → ${fav['destination']}'),
        );
      },
    );
  }
}

