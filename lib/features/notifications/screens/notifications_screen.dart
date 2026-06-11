import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// ── Model & Provider ─────────────────────────────────────────────────────────

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final String channel; // incident | schedule | crowd | route
  final DateTime createdAt;
  final bool isRead;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.channel,
    required this.createdAt,
    this.isRead = false,
  });

  NotificationItem copyWith({bool? isRead}) => NotificationItem(
        id: id,
        title: title,
        body: body,
        channel: channel,
        createdAt: createdAt,
        isRead: isRead ?? this.isRead,
      );
}

class NotificationsNotifier extends StateNotifier<List<NotificationItem>> {
  NotificationsNotifier() : super(_dummyNotifications());

  static List<NotificationItem> _dummyNotifications() {
    final now = DateTime.now();
    return [
      NotificationItem(
        id: '1',
        title: '⚠️ Gangguan KRL Jalur Bogor',
        body: 'Perjalanan KRL Bogor–Jakarta Kota terhambat 15 menit akibat gangguan sinyal di Stasiun Manggarai.',
        channel: 'incident',
        createdAt: now.subtract(const Duration(minutes: 5)),
      ),
      NotificationItem(
        id: '2',
        title: '🚉 Jadwal KRL Diperbaharui',
        body: 'Kereta pukul 07:45 dari Stasiun Depok akan tiba 7 menit lebih awal hari ini.',
        channel: 'schedule',
        createdAt: now.subtract(const Duration(minutes: 30)),
        isRead: true,
      ),
      NotificationItem(
        id: '3',
        title: '🟡 Kepadatan Tinggi – MRT Lebak Bulus',
        body: 'Stasiun MRT Lebak Bulus diprediksi padat pada jam 17:30–19:00. Pertimbangkan berangkat lebih awal.',
        channel: 'crowd',
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
      NotificationItem(
        id: '4',
        title: '🗺️ Rute Alternatif Tersedia',
        body: 'Rute alternatif via Busway 1E ke Blok M tersedia untuk menghindari kemacetan di jalur MRT.',
        channel: 'route',
        createdAt: now.subtract(const Duration(hours: 3)),
        isRead: true,
      ),
      NotificationItem(
        id: '5',
        title: '⚠️ Insiden Jalan di Halte Blok M',
        body: 'Terdeteksi insiden penumpang di Halte Blok M. Harap berhati-hati dan ikuti petunjuk petugas.',
        channel: 'incident',
        createdAt: now.subtract(const Duration(hours: 5)),
        isRead: true,
      ),
      NotificationItem(
        id: '6',
        title: '🚌 Busway Koridor 9 Normal Kembali',
        body: 'Layanan Busway Koridor 9 (Pinang Ranti–Pluit) telah kembali normal setelah pemeliharaan.',
        channel: 'schedule',
        createdAt: now.subtract(const Duration(hours: 8)),
        isRead: true,
      ),
    ];
  }

  void markAsRead(String id) {
    state = state.map((n) => n.id == id ? n.copyWith(isRead: true) : n).toList();
  }

  void markAllRead() {
    state = state.map((n) => n.copyWith(isRead: true)).toList();
  }

  void delete(String id) {
    state = state.where((n) => n.id != id).toList();
  }

  void clearAll() => state = [];

  int get unreadCount => state.where((n) => !n.isRead).length;
}

final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, List<NotificationItem>>(
        (_) => NotificationsNotifier());

// ── Screen ───────────────────────────────────────────────────────────────────

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);
    final notifier = ref.read(notificationsProvider.notifier);
    final unread = notifications.where((n) => !n.isRead).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          unread > 0 ? 'Notifikasi ($unread)' : 'Notifikasi',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (unread > 0)
            TextButton(
              onPressed: () => notifier.markAllRead(),
              child: const Text('Baca Semua'),
            ),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'clear') {
                _showClearDialog(context, notifier);
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'clear',
                child: ListTile(
                  leading: Icon(Icons.delete_sweep_outlined, color: Colors.red),
                  title: Text('Hapus Semua'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: notifications.isEmpty
          ? _buildEmpty(context)
          : _buildList(context, notifications, notifier),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none_outlined,
              size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            'Tidak ada notifikasi',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            'Notifikasi tentang insiden, jadwal, dan\nkepadatan akan muncul di sini.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    List<NotificationItem> notifications,
    NotificationsNotifier notifier,
  ) {
    // Group by date
    final today = <NotificationItem>[];
    final earlier = <NotificationItem>[];
    final now = DateTime.now();
    for (final n in notifications) {
      if (now.difference(n.createdAt).inHours < 24) {
        today.add(n);
      } else {
        earlier.add(n);
      }
    }

    return ListView(
      children: [
        if (today.isNotEmpty) ...[
          _sectionHeader('Hari Ini'),
          ...today.map((n) => _buildTile(context, n, notifier)),
        ],
        if (earlier.isNotEmpty) ...[
          _sectionHeader('Sebelumnya'),
          ...earlier.map((n) => _buildTile(context, n, notifier)),
        ],
      ],
    );
  }

  Widget _sectionHeader(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Text(
        label,
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildTile(
    BuildContext context,
    NotificationItem n,
    NotificationsNotifier notifier,
  ) {
    return Dismissible(
      key: Key(n.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => notifier.delete(n.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red,
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: InkWell(
        onTap: () => notifier.markAsRead(n.id),
        child: Container(
          color: n.isRead ? null : Theme.of(context).colorScheme.primary.withOpacity(0.05),
          child: ListTile(
            leading: _channelIcon(context, n.channel, n.isRead),
            title: Text(
              n.title,
              style: TextStyle(
                fontWeight: n.isRead ? FontWeight.normal : FontWeight.bold,
                fontSize: 14,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                Text(n.body, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 4),
                Text(
                  _timeAgo(n.createdAt),
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
            trailing: n.isRead
                ? null
                : Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }

  Widget _channelIcon(BuildContext context, String channel, bool isRead) {
    final Map<String, Map<String, dynamic>> config = {
      'incident': {'icon': Icons.warning_amber_rounded, 'color': Colors.red},
      'schedule': {'icon': Icons.schedule_rounded, 'color': Colors.blue},
      'crowd': {'icon': Icons.people_alt_outlined, 'color': Colors.orange},
      'route': {'icon': Icons.alt_route_rounded, 'color': Colors.green},
    };
    final cfg = config[channel] ??
        {'icon': Icons.notifications_outlined, 'color': Colors.grey};
    final color = cfg['color'] as Color;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isRead ? Colors.grey[100] : color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        cfg['icon'] as IconData,
        color: isRead ? Colors.grey : color,
        size: 22,
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    return '${diff.inDays} hari lalu';
  }

  void _showClearDialog(BuildContext context, NotificationsNotifier notifier) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Semua Notifikasi'),
        content: const Text('Semua notifikasi akan dihapus. Lanjutkan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              notifier.clearAll();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
