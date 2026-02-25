// widgets/app_bottom_nav.dart
import 'package:flutter/material.dart';
import 'theme.dart';


class BottomNavigation extends StatelessWidget {
  final String  currentRoute;

  const BottomNavigation({
    super.key,
    required this.currentRoute,
  });

    int _getIndex() {
    switch (currentRoute) {
      case '/leaderboard':
        return 4;
      case '/garden':
        return 3;
      case '/activity-log':
        return 2;
      case '/profile':
        return 1;
      case '/home':
      default:
        return 0;
    }
  }

  /*@override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _getIndex(),
      onTap: (currentIndex) {
        if (currentIndex == 0) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (currentIndex == 1) {
          Navigator.pushReplacementNamed(context, '/profile');
        } else if (currentIndex == 2) {
          Navigator.pushReplacementNamed(context, '/activity-log');
        } else if (currentIndex == 3) {
          Navigator.pushReplacementNamed(context, '/garden');
        } else if (currentIndex == 4) {
          Navigator.pushReplacementNamed(context, '/leaderboard');
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Log Action"),
        BottomNavigationBarItem(icon: Icon(Icons.grass), label: "Garden"),
        BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: "Leaderboard"),
      ],
    );
  }*/

  void _go(BuildContext context, int i) {
    const routes = ['/home', '/profile', '/activity-log', '/garden', '/leaderboard'];
    Navigator.pushReplacementNamed(context, routes[i]);
  }

   @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return NavigationBar(
      selectedIndex: _getIndex(),
      onDestinationSelected: (i) => _go(context, i),
      // Use theme container color so dark mode works.
      backgroundColor: cs.secondaryContainer,
      indicatorColor: cs.secondary,          
      indicatorShape: const StadiumBorder(), 
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        NavigationDestination(icon: Icon(Icons.add), label: 'Log Action'),
        NavigationDestination(icon: Icon(Icons.grass), label: 'Garden'),
        NavigationDestination(icon: Icon(Icons.leaderboard), label: 'Leaderboard'),
      ],
    );
  }
}