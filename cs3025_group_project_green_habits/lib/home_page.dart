import 'package:flutter/material.dart';
import 'widgets/theme.dart';
import 'widgets/bottomNavigationBar.dart';
import 'widgets/header.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final String _username = "Alice Brown"; // TODO: Replace with actual username once database is established


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        title: "Home",
        helpText: "This is your homepage",
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
             Text(
              'Welcome Back, $_username',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            //TODO: Add garden preview
            Text(
              'Virtural Garden',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            //TODO: Add most recently used actions 
            Text(
              'Quick-Action Bar',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            //TODO: Add leaderboard
            Text(
              'Leaderboard',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
       bottomNavigationBar: BottomNavigation (
        currentRoute: "/home"
      ),
    );
  }
}
