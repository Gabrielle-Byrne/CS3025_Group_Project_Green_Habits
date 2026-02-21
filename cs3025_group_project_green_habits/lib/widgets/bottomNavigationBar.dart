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
      case '/actvity-log':
        return 2;
      case '/profile':
        return 1;
      case '/':
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _getIndex(),
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/profile');
        } else if (index == 2) {
          Navigator.pushReplacementNamed(context, '/actvity-log');
        } else if (index == 3) {
          Navigator.pushReplacementNamed(context, '/garden');
        } else if (index == 4) {
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
      // backgroundColor: lightMode.surface,
      // selectedItemColor: lightMode.primary,
      // unselectedItemColor: lightMode.onSurfaceVariant,
    );
  }
}