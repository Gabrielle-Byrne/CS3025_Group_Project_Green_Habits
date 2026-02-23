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
  final String username;
  final int points;

  User(this.username, this.points);
}


class _LeaderboardPageState extends State<LeaderboardPage> {
  final String _username = "Alice Brown";
  final int points = 1400;

List<User> users = [
  User("Andi Green", 1920),
  User("Peri Winkle", 1590),
  User("Chase McGee", 1200),
  User("Micheal Gray", 910),
  User("Amanda Gray", 770),
  User("Greta Hill", 500),
  User("Max Chow", 220),
  User("Yohanne Green", 180),
  User("Dana", 30),
  User("Jane Doe", 30),
];

String get userName => users[1].username;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        title: "Leaderboard",
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
                    "2. $users[2].username",
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