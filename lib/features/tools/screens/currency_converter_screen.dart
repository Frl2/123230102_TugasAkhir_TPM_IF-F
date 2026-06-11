import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../providers/tools_provider.dart';

class CurrencyConverterScreen extends ConsumerStatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  ConsumerState<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState
    extends ConsumerState<CurrencyConverterScreen> {
  final _amountCtrl = TextEditingController(text: '100000');
  String _fromCurrency = 'IDR';
  String _toCurrency = 'USD';

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  void _swap() {
    setState(() {
      final tmp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = tmp;
    });
  }

  double get _result {
    final amount = double.tryParse(
            _amountCtrl.text.replaceAll(',', '').replaceAll('.', '')) ??
        0;
    return ref.read(toolsProvider.notifier).convert(amount, _fromCurrency, _toCurrency);
  }

  @override
  Widget build(BuildContext context) {
    final toolsState = ref.watch(toolsProvider);
    final currencies = AppConstants.currencies;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Mata Uang'),
        actions: [
          IconButton(
            onPressed: () => ref.read(toolsProvider.notifier).fetchRates(),
            icon: toolsState.isLoadingRates
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Info kurs terakhir diperbarui
            if (toolsState.lastUpdated != null)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.safeGreen.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline,
                        size: 14, color: AppTheme.safeGreen),
                    const SizedBox(width: 6),
                    Text(
                      'Kurs diperbarui: ${DateFormat('HH:mm, dd MMM').format(toolsState.lastUpdated!)}',
                      style: TextStyle(
                          fontSize: 12, color: AppTheme.safeGreen),
                    ),
                  ],
                ),
              ),
            if (toolsState.error != null)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.warningAmber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_outlined,
                        size: 14, color: AppTheme.warningAmber),
                    const SizedBox(width: 6),
                    Text(toolsState.error!,
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.warningAmber)),
                  ],
                ),
              ),
            const SizedBox(height: 24),

            // From
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dari', style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountCtrl,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: AppTheme.primaryBlue),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                        DropdownButton<String>(
                          value: _fromCurrency,
                          underline: const SizedBox(),
                          items: currencies.map((c) {
                            return DropdownMenuItem(
                              value: c['code'],
                              child: Text('${c['symbol']} ${c['code']}'),
                            );
                          }).toList(),
                          onChanged: (v) =>
                              setState(() => _fromCurrency = v!),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Swap button
            Center(
              child: IconButton(
                onPressed: _swap,
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.swap_vert_rounded,
                      color: Colors.white, size: 20),
                ),
              ),
            ),

            // To
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ke', style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _result.toStringAsFixed(
                                _toCurrency == 'JPY' ? 0 : 2),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    color: AppTheme.accentTeal,
                                    fontWeight: FontWeight.w700),
                          ),
                        ),
                        DropdownButton<String>(
                          value: _toCurrency,
                          underline: const SizedBox(),
                          items: currencies.map((c) {
                            return DropdownMenuItem(
                              value: c['code'],
                              child: Text('${c['symbol']} ${c['code']}'),
                            );
                          }).toList(),
                          onChanged: (v) => setState(() => _toCurrency = v!),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // All currencies table
            Text('Semua Nilai Tukar (per 1 IDR)',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: AppConstants.currencies
                    .where((c) => c['code'] != 'IDR')
                    .map((c) {
                  final rate = toolsState.rates[c['code']] ?? 0;
                  return ListTile(
                    dense: true,
                    leading: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          c['symbol']!,
                          style: TextStyle(
                            color: AppTheme.primaryBlue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    title: Text(c['name']!),
                    subtitle: Text(c['code']!),
                    trailing: Text(
                      rate > 0 ? rate.toStringAsFixed(6) : '-',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
