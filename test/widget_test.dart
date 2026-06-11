import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:urbansafe_app/main.dart';
import 'package:urbansafe_app/data/database/app_database.dart';

void main() {
  testWidgets('UrbanSafe app launches without crashing',
      (WidgetTester tester) async {
    final db = AppDatabase();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
        ],
        child: const UrbanSafeApp(),
      ),
    );

    // App should render at least one widget
    expect(find.byType(MaterialApp), findsOneWidget);

    await db.close();
  });
}
