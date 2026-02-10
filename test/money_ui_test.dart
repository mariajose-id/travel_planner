import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_form.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  Widget createTripForm() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: Scaffold(body: TripForm(onSave: (_) {})),
    );
  }

  group('TripForm Money Input', () {
    testWidgets('should show error for empty budget', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTripForm());
      await tester.pumpAndSettle();

      final addButton = find.text('Add Trip');
      await tester.ensureVisible(addButton);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.text('This field is required'), findsWidgets);
    });

    testWidgets('should show error for invalid number', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTripForm());
      await tester.pumpAndSettle();

      // Find by label instead of index for robustness
      final budgetField = find
          .ancestor(of: find.text('Budget'), matching: find.byType(Column))
          .first;

      final textField = find.descendant(
        of: budgetField,
        matching: find.byType(TextField),
      );

      await tester.enterText(textField, 'not-a-number');

      final addButton = find.text('Add Trip');
      await tester.ensureVisible(addButton);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid number'), findsOneWidget);
    });

    testWidgets('should accept valid budget', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTripForm());
      await tester.pumpAndSettle();

      final budgetField = find
          .ancestor(of: find.text('Budget'), matching: find.byType(Column))
          .first;

      final textField = find.descendant(
        of: budgetField,
        matching: find.byType(TextField),
      );

      await tester.enterText(textField, '1500.50');

      final addButton = find.text('Add Trip');
      await tester.ensureVisible(addButton);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid number'), findsNothing);
    });
  });
}
