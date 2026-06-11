import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../core/constants/app_constants.dart';

class ToolsState {
  final Map<String, double> rates; // currency code -> rate per 1 IDR
  final bool isLoadingRates;
  final String? error;
  final DateTime? lastUpdated;

  const ToolsState({
    this.rates = const {},
    this.isLoadingRates = false,
    this.error,
    this.lastUpdated,
  });

  ToolsState copyWith({
    Map<String, double>? rates,
    bool? isLoadingRates,
    String? error,
    DateTime? lastUpdated,
  }) => ToolsState(
    rates: rates ?? this.rates,
    isLoadingRates: isLoadingRates ?? this.isLoadingRates,
    error: error,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
}

class ToolsNotifier extends Notifier<ToolsState> {
  final Dio _dio = Dio();

  @override
  ToolsState build() {
    // Auto-fetch saat pertama kali
    Future.microtask(() => fetchRates());
    return const ToolsState();
  }

  Future<void> fetchRates() async {
    state = state.copyWith(isLoadingRates: true, error: null);
    try {
      final response = await _dio.get(AppConstants.exchangeRateUrl);
      final data = response.data as Map<String, dynamic>;
      final ratesRaw = data['rates'] as Map<String, dynamic>;

      // API memberikan rate per 1 IDR
      final rates = <String, double>{};
      for (final c in AppConstants.currencies) {
        final code = c['code']!;
        if (code != 'IDR' && ratesRaw.containsKey(code)) {
          rates[code] = (ratesRaw[code] as num).toDouble();
        }
      }

      state = state.copyWith(
        rates: rates,
        isLoadingRates: false,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      // Fallback hardcoded rates jika API gagal
      state = state.copyWith(
        rates: {
          'USD': 0.000064,
          'EUR': 0.000059,
          'JPY': 0.0096,
          'SGD': 0.000086,
          'MYR': 0.000300,
          'GBP': 0.000050,
        },
        isLoadingRates: false,
        error: 'Menggunakan kurs offline',
      );
    }
  }

  /// Konversi dari IDR ke currency lain
  double convertFromIdr(double idrAmount, String targetCurrency) {
    final rate = state.rates[targetCurrency] ?? 0;
    return idrAmount * rate;
  }

  /// Konversi dari currency lain ke IDR
  double convertToIdr(double amount, String sourceCurrency) {
    final rate = state.rates[sourceCurrency] ?? 0;
    if (rate == 0) return 0;
    return amount / rate;
  }

  /// Konversi antar mata uang (via IDR sebagai pivot)
  double convert(double amount, String from, String to) {
    if (from == to) return amount;
    if (from == 'IDR') return convertFromIdr(amount, to);
    if (to == 'IDR') return convertToIdr(amount, from);
    final idrAmount = convertToIdr(amount, from);
    return convertFromIdr(idrAmount, to);
  }
}

final toolsProvider = NotifierProvider<ToolsNotifier, ToolsState>(ToolsNotifier.new);
