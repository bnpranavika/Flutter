import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/UI_Elements.dart'; // import your UI elements

void main() {
  group('UIElementsTab Tests', () {
    testWidgets('UIElementsTab should render a list of items',
        (WidgetTester tester) async {
      // Build the UIElementsTab widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UIElementsTab()),
        ),
      );

      // Verify the UIElementsTab renders
      expect(find.byType(UIElementsTab), findsOneWidget);

      // Check for ListView or Column
      expect(find.byType(ListView), findsOneWidget); // if you use ListView
      // expect(find.byType(Column), findsWidgets); // if you use Column

      // Verify that certain list items exist
      expect(find.text('Item 1'), findsOneWidget); // replace with actual items
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('Tapping on a ListTile triggers expected action',
        (WidgetTester tester) async {
      bool tapped = false;

      // Use a modified widget for testing callback
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  title: const Text('Tap me'),
                  onTap: () {
                    tapped = true;
                  },
                ),
              ],
            ),
          ),
        ),
      );

      // Tap the ListTile
      await tester.tap(find.text('Tap me'));
      await tester.pump(); // rebuild UI after tap

      // Verify tap changed the variable
      expect(tapped, true);
    });
  });
}
