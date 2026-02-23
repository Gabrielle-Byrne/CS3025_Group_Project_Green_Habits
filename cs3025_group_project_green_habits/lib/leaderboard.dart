import 'package:flutter/material.dart';
import 'widgets/theme.dart';
import 'widgets/bottomNavigationBar.dart';
import 'widgets/header.dart';


class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class User {
  final String name;
  final int points;

  User(this.name, this.points);
}


class _LeaderboardPageState extends State<LeaderboardPage> {
  final String _username = "Alice Brown"; // TODO: Replace with actual username once database is established
  final int points = 140;

List<User> users = [
  User("Andi Green", 1920),
  User("Peri Winkle", 1490),
  User("Chase McGee", 1200),
];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        title: "Leaderboard (BETA)",
        helpText: "This is the leaderboard, where users can compare their scores",
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: .center,
          children: <Widget>[
            Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Icon(Icons.person_2_outlined, color: Color.fromRGBO(206, 198, 198, 1)),
                    SizedBox(height: 20),
                    Text(
                    "2. $users",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                        ),
                      ),
                    ],
                  ),
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