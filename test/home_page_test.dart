import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/src/pages/home_page.dart';

void main() {
  testWidgets('Find text Pokedex', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    expect(find.text('Pokedex'), findsOneWidget);
  });
}
