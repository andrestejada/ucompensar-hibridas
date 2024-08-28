import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    print(location);
    switch (location) {
      case '/proposals':
        return 0;

      case '/create-proposal':
        return 1;

      case '/favorites':
        return 2;

      default:
        return 0;
    }
  }

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/proposals');
        break;
      case 1:
        context.go('/create-proposal');
        break;
      case 2:
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: Colors.amber[800],
        currentIndex: getCurrentIndex(context),
        onTap: (value) => onItemTapped(context, value),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_max), label: 'Propuestas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.create), label: 'Crear Propuesta'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
        ]);
  }
}
