import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pokedex/src/pages/home_page.dart';

void main() {
  testWidgets('Find text Pokedex', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(home: HomePage()));
    expect(find.text('Pokedex'), findsOneWidget);
  });
}
