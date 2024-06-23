import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_de_habitos/main.dart';
import 'package:gestion_de_habitos/screens/profile_screen.dart';
import 'package:gestion_de_habitos/screens/habit_screen.dart';  // Asegúrate de importar HabitScreen

void main() {
  testWidgets('Add Profile Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(GestionDeHabitosApp());

    // Verify that the ProfileScreen is displayed.
    expect(find.byType(ProfileScreen), findsOneWidget);

    // Tap the '+' icon to add a new profile.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Enter a name for the profile.
    await tester.enterText(find.byType(TextField), 'Test Profile');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();

    // Verify that the new profile is displayed.
    expect(find.text('Test Profile'), findsOneWidget);
  });

  testWidgets('Add Habit Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(GestionDeHabitosApp());

    // Add a profile first
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'Test Profile');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();

    // Verify that the ProfileScreen is displayed.
    expect(find.text('Test Profile'), findsOneWidget);

    // Tap on the created profile
    await tester.tap(find.text('Test Profile'));
    await tester.pumpAndSettle();

    // Verify that we are on the HabitScreen
    expect(find.byType(HabitScreen), findsOneWidget);

    // Tap the '+' icon to add a new habit.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Enter a name for the habit.
    await tester.enterText(find.byType(TextField), 'Test Habit');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();

    // Verify that the new habit is displayed.
    expect(find.text('Test Habit'), findsOneWidget);
  });
}
