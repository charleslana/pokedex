import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/src/pages/home_page.dart';
import 'package:pokedex/src/widgets/poke_loading.dart';

void main() {
  testWidgets('Find text Pokedex', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    expect(find.text('Pokedex'), findsOneWidget);
  });

  testWidgets('Find the active PokeLoading widget', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    expect(find.byType(PokeLoading), findsOneWidget);
  });
}
