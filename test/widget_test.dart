import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safe_learn/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('JOJ App starts', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: JojApp(),
      ),
    );
    // Onboarding ou splash initial
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
