import 'package:flutter/material.dart';
import 'widgets/theme.dart';
import 'widgets/bottomNavigationBar.dart';
import 'widgets/header.dart';


class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final String _username = "Alice Brown"; // TODO: Replace with actual username once database is established

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        title: "Leaderboard",
        helpText: "This is the leaderboard ",
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: .center,
          children: [
             Icon(
              Icons.leaderboard_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
             Text(
              '$_username',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
       bottomNavigationBar: BottomNavigation (
        currentRoute: "/leaderboard"
      ),
    );
  }
}
