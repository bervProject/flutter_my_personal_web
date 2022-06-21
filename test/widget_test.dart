// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_web_mobile/main.dart';

void main() {
  testWidgets('Button trigger download text', (WidgetTester tester) async {
    const buttonKey = Key('buttonKey');
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(buttonKey: buttonKey));

    // Verify that our null still there.
    expect(find.text('null'), findsWidgets);
    expect(find.byKey(buttonKey), findsOneWidget);

    // Tap the button and trigger a frame.
    await tester.tap(find.byKey(buttonKey));
    await tester.pumpAndSettle();

    // Verify that we got Failed Download Data
    expect(find.text('Failed Download Data'), findsOneWidget);
  });
}
