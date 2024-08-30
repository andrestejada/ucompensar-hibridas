import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:residents_app/screen/home_screen.dart';
import 'package:residents_app/screen/login_screen.dart';
import 'package:residents_app/screen/sign_up_screen.dart';
import 'package:residents_app/views/create_proposal_view.dart';
import 'package:residents_app/views/favorites_view.dart';
import 'package:residents_app/views/proposals_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignUpScreen(),
      ),
      ShellRoute(
          builder: (context, state, child) {
            return HomeScreen(childView: child);
          },
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) {
                return const FavoritesView();
              },
            ),
            GoRoute(
              path: '/create-proposal',
              builder: (context, state) {
                return const CreateProposalView();
              },
            ),
            GoRoute(
              path: '/proposals',
              builder: (context, state) {
                return const ProposalsView();
              },
            ),
          ])
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
