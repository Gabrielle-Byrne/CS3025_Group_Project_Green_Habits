import 'package:flutter/material.dart';
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
        child: Column(
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
            Container(
              width: 300,
              height: 100,
              color: const Color.fromRGBO(117, 228, 119, 1), 
              alignment: Alignment.center, 
              margin: EdgeInsets.all(20), 
              padding: EdgeInsets.all(30), 
              child: Icon(Icons.forest), 
            ),
            //TODO: Add most recently used actions 
            Text(
              'Quick-Action Bar',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              height: 100,
              color: const Color.fromRGBO(117, 228, 119, 1), 
              alignment: Alignment.center, 
              margin: EdgeInsets.all(20), 
              padding: EdgeInsets.all(30),
              child: Row (mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/tips');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Learn how to be more eco-friendly',
                    style: TextStyle(
                    ),
                  ),
                ),
              ),],)
            ),
            //TODO: Add leaderboard
            Text(
              'Leaderboard',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: <Widget>[
                SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/tips');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Learn how to be more eco-friendly',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                    ),
                  ),
                ),
              ),
                SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                   Navigator.pushReplacementNamed(context, '/history');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'View Past Actions',
                    style: TextStyle(
                    ),
                  ),
                ),
              ),
              ],
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
