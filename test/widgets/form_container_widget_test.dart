import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:residents_app/widgets/form_container_widget.dart';

void main() {
  group('FormContainerWidget Tests', () {
    testWidgets('renders text field with hint text', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormContainerWidget(
              controller: controller,
              hintText: 'Test Hint',
            ),
          ),
        ),
      );

      expect(find.text('Test Hint'), findsOneWidget);
    });

    testWidgets('accepts text input', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormContainerWidget(
              controller: controller,
              hintText: 'Enter text',
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'Test input');
      expect(controller.text, 'Test input');
    });

    testWidgets('shows password toggle icon when isPasswordField is true', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormContainerWidget(
              controller: controller,
              hintText: 'Password',
              isPasswordField: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('renders as text area when isTextArea is true', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormContainerWidget(
              controller: controller,
              hintText: 'Description',
              isTextArea: true,
            ),
          ),
        ),
      );

      // Verify text area widget exists
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });
  });
}
