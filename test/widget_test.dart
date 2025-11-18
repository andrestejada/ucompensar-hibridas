// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:residents_app/widgets/custom_botton_navigation.dart';
import 'package:residents_app/widgets/form_container_widget.dart';

class _TestScaffold extends StatelessWidget {
  final String label;

  const _TestScaffold({required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(label, key: ValueKey<String>('screen-$label')),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

void main() {
  testWidgets('FormContainerWidget shows password field with toggle icon', (tester) async {
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

    // Verify password field has visibility toggle icon
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Tap the toggle icon
    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pumpAndSettle();

    // Icon should change to visibility (shown state)
    expect(find.byIcon(Icons.visibility), findsOneWidget);
  });

  testWidgets('CustomBottomNavigation reflects current route', (tester) async {
    final router = GoRouter(
      initialLocation: '/favorites',
      routes: [
        GoRoute(
          path: '/proposals',
          builder: (context, state) => const _TestScaffold(label: 'Propuestas'),
        ),
        GoRoute(
          path: '/create-proposal',
          builder: (context, state) => const _TestScaffold(label: 'Crear Propuesta'),
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const _TestScaffold(label: 'Favoritos'),
        ),
        GoRoute(
          path: '/announcement',
          builder: (context, state) => const _TestScaffold(label: 'Anuncios'),
        ),
      ],
    );

    addTearDown(router.dispose);

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    final navBar = tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
    expect(navBar.currentIndex, 2);
  });

  testWidgets('CustomBottomNavigation navigates to tapped item', (tester) async {
    late final GoRouter router;
    router = GoRouter(
      initialLocation: '/proposals',
      routes: [
        GoRoute(
          path: '/proposals',
          builder: (context, state) => const _TestScaffold(label: 'Propuestas'),
        ),
        GoRoute(
          path: '/create-proposal',
          builder: (context, state) => const _TestScaffold(label: 'Crear Propuesta'),
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const _TestScaffold(label: 'Favoritos'),
        ),
        GoRoute(
          path: '/announcement',
          builder: (context, state) => const _TestScaffold(label: 'Anuncios'),
        ),
      ],
    );

    addTearDown(router.dispose);

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Anuncios'));
    await tester.pumpAndSettle();

    // Verify navigation occurred by checking screen content
    expect(find.byKey(const ValueKey<String>('screen-Anuncios')), findsOneWidget);
  });
}
