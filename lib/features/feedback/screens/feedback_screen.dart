import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/database/app_database.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../main.dart';
import '../../auth/providers/auth_provider.dart';

// ── Provider ────────────────────────────────────────────────────────────────

class FeedbackState {
  final List<FeedbackEntry> entries;
  final bool isLoading;
  final bool isSending;
  final String? successMessage;
  final String? errorMessage;

  const FeedbackState({
    this.entries = const [],
    this.isLoading = false,
    this.isSending = false,
    this.successMessage,
    this.errorMessage,
  });

  FeedbackState copyWith({
    List<FeedbackEntry>? entries,
    bool? isLoading,
    bool? isSending,
    String? successMessage,
    String? errorMessage,
  }) {
    return FeedbackState(
      entries: entries ?? this.entries,
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      successMessage: successMessage,
      errorMessage: errorMessage,
    );
  }
}

class FeedbackNotifier extends StateNotifier<FeedbackState> {
  final AppDatabase _db;
  final AuthService _auth;

  FeedbackNotifier(this._db, this._auth) : super(const FeedbackState()) {
    _load();
  }

  Future<void> _load() async {
    state = state.copyWith(isLoading: true);
    final user = await _auth.getCurrentUser();
    if (user == null) {
      state = state.copyWith(isLoading: false);
      return;
    }
    final entries = await _db.getFeedbackByUser(user.id);
    state = state.copyWith(entries: entries, isLoading: false);
  }

  Future<void> submit({
    required String category,
    required String message,
    required int rating,
  }) async {
    state = state.copyWith(isSending: true);
    try {
      final user = await _auth.getCurrentUser();
      if (user == null) {
        state = state.copyWith(
            isSending: false, errorMessage: 'Sesi tidak ditemukan');
        return;
      }
      await _db.insertFeedbackNamed(
        userId: user.id,
        category: category,
        message: message,
        rating: rating,
      );
      await _load();
      state = state.copyWith(
        isSending: false,
        successMessage: 'Saran & kesan berhasil dikirim, terima kasih!',
      );
    } catch (e) {
      state = state.copyWith(
          isSending: false, errorMessage: 'Gagal mengirim: $e');
    }
  }

  void clearMessages() =>
      state = state.copyWith(successMessage: null, errorMessage: null);
}

final feedbackProvider =
    StateNotifierProvider<FeedbackNotifier, FeedbackState>((ref) {
  return FeedbackNotifier(
    ref.watch(appDatabaseProvider),
    ref.watch(authServiceProvider),
  );
});

// ── Screen ───────────────────────────────────────────────────────────────────

class FeedbackScreen extends ConsumerStatefulWidget {
  const FeedbackScreen({super.key});

  @override
  ConsumerState<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends ConsumerState<FeedbackScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  final _formKey = GlobalKey<FormState>();
  final _messageCtrl = TextEditingController();
  String _selectedCategory = 'Fitur';
  int _rating = 5;

  final _categories = [
    'Fitur',
    'Tampilan',
    'Performa',
    'Navigasi',
    'Keamanan',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feedbackProvider);
    final notifier = ref.read(feedbackProvider.notifier);

    ref.listen<FeedbackState>(feedbackProvider, (_, next) {
      if (next.successMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.successMessage!),
            backgroundColor: Colors.green,
          ),
        );
        _messageCtrl.clear();
        setState(() {
          _selectedCategory = 'Fitur';
          _rating = 5;
        });
        notifier.clearMessages();
        _tabCtrl.animateTo(1);
      }
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(next.errorMessage!),
              backgroundColor: Colors.red),
        );
        notifier.clearMessages();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saran & Kesan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        bottom: TabBar(
          controller: _tabCtrl,
          tabs: const [
            Tab(icon: Icon(Icons.edit_outlined), text: 'Kirim'),
            Tab(icon: Icon(Icons.history_outlined), text: 'Riwayat'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _buildSubmitTab(state, notifier),
          _buildHistoryTab(state),
        ],
      ),
    );
  }

  Widget _buildSubmitTab(FeedbackState state, FeedbackNotifier notifier) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header banner
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.feedback_outlined,
                      color: Colors.white, size: 36),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Bantu Kami Berkembang',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Saran dan kesanmu sangat berarti untuk pengembangan UrbanSafe.',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Rating
            const Text('Rating Kepuasan',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                return GestureDetector(
                  onTap: () => setState(() => _rating = i + 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      i < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                      size: 40,
                      color: i < _rating ? Colors.amber : Colors.grey[300],
                    ),
                  ),
                );
              }),
            ),
            Center(
              child: Text(
                _ratingLabel(_rating),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Category
            const Text('Kategori',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _categories.map((cat) {
                final selected = _selectedCategory == cat;
                return ChoiceChip(
                  label: Text(cat),
                  selected: selected,
                  onSelected: (_) =>
                      setState(() => _selectedCategory = cat),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  labelStyle: TextStyle(
                      color: selected ? Colors.white : null),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.md),

            // Message
            const Text('Pesan',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _messageCtrl,
              maxLines: 5,
              maxLength: 500,
              decoration: InputDecoration(
                hintText:
                    'Tuliskan saran, kesan, atau keluhan Anda tentang UrbanSafe...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty)
                  return 'Pesan tidak boleh kosong';
                if (v.trim().length < 10) return 'Pesan minimal 10 karakter';
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.md),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: state.isSending
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          notifier.submit(
                            category: _selectedCategory,
                            message: _messageCtrl.text.trim(),
                            rating: _rating,
                          );
                        }
                      },
                icon: state.isSending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send_rounded),
                label: Text(state.isSending ? 'Mengirim...' : 'Kirim Saran & Kesan'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTab(FeedbackState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined,
                size: 64, color: Colors.grey[300]),
            const SizedBox(height: 12),
            const Text('Belum ada saran yang dikirim',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: state.entries.length,
      itemBuilder: (ctx, i) {
        final entry = state.entries[i];
        return Card(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(entry.subject,
                          style: TextStyle(
                              fontSize: 11,
                              color:
                                  Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600)),
                    ),
                    const Spacer(),
                    Row(
                      children: List.generate(
                        5,
                        (j) => Icon(
                          j < entry.rating
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          size: 14,
                          color: j < entry.rating
                              ? Colors.amber
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(entry.saran,
                    style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 6),
                Text(
                  _formatDate(entry.createdAt),
                  style:
                      const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _ratingLabel(int r) {
    switch (r) {
      case 1:
        return 'Sangat Buruk';
      case 2:
        return 'Buruk';
      case 3:
        return 'Cukup';
      case 4:
        return 'Baik';
      case 5:
        return 'Sangat Baik';
      default:
        return '';
    }
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year} '
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
}
