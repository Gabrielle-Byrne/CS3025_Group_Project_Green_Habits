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
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: .center,
          children: [
             Text(
              'Welcome Back, $_username!',
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
                    Navigator.pushReplacementNamed(context, '/activity-log');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Log Activity',
                    style: TextStyle(
                    ),
                  ),
                ),
              ),],)
            ),

            OverflowBar(
              spacing: 8,
              overflowSpacing: 8,
              overflowAlignment: OverflowBarAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Text(
                    "Top 3 this week",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                        ),
                      ),
                    SizedBox(height: 10),
                    Text(
                    "1. Billy Green\n2. Alice Brown\n3. Micheal Gray",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                        ),
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
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
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
               Container(
                  decoration: BoxDecoration(
                    //color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    SizedBox(height: 30),
                    SizedBox(
                    width: 100,
                        child: LinearProgressIndicator(
                          minHeight: 20,
                          backgroundColor: Color.fromARGB(255, 225, 255, 255),
                          value: 0.8,
                        ),
                    ), 
                    SizedBox(height: 10),
                    Text(
                   "80% of the way to the next reward!",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                        ),
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/history');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                          child: Text(
                            'View Your Past Actions',
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ),
       bottomNavigationBar: BottomNavigation (
        currentRoute: "/home"
      ),
    );
  }
}
