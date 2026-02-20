import 'package:flutter/material.dart';
import 'widgets/theme.dart';
import 'widgets/bottomNavigationBar.dart';
import 'widgets/header.dart';


class ActivityLogPage extends StatefulWidget {
  const ActivityLogPage({super.key});

  @override
  State<ActivityLogPage> createState() => _ActivityLogPageState();
}

class _ActivityLogPageState extends State<ActivityLogPage> {
  String _username = "Alice Brown"; // TODO: Replace with actual username once database is established

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        title: "Activity Log",
        helpText: "This is your activity log, where you can log in the eco-friendy actions you've performed",
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              'Activity Logger',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
       bottomNavigationBar: BottomNavigation (
        currentRoute: "/activity-log"
      ),
    );
  }
}
