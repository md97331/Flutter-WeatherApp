import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mp5/views/login.dart';
import 'package:flutter/material.dart';
import 'package:mp5/services/SessionManager.dart';
import 'package:mp5/views/HomeScreen.dart';


class MockSessionManager extends Mock implements SessionManager {}

void main() {
  testWidgets('HomeScreen updates UI after loading',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: HomeScreen(cityName: 'New York')));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('No weather data available.'),
        findsOneWidget); // or findsNothing based on actual behavior
  });
  testWidgets('HomeScreen shows loading indicator initially',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: HomeScreen(cityName: 'New York')));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  testWidgets('Add a new user', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // Rebuild the widget to show the dialog

    await tester.enterText(find.byType(TextField), 'new_user');
    await tester.tap(find.text('Add'));
    await tester
        .pumpAndSettle(); // Wait for the dialog to close and list to update

  });
  
}
