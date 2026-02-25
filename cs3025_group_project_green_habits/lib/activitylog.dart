import 'package:flutter/material.dart';
import 'widgets/bottomNavigationBar.dart';
import 'widgets/header.dart';


class ActivityLogPage extends StatefulWidget {
  const ActivityLogPage({super.key});

  @override
  State<ActivityLogPage> createState() => _ActivityLogPageState();
}

class _ActivityLogPageState extends State<ActivityLogPage> {
  
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

            //Picture


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Go to Gallery',
                    style: TextStyle(
                    ),
                  ),
                ),
              ),
                SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Take New Photo',
                    style: TextStyle(
                    ),
                  ),
                ),
              ),
              ],
            ),

            SizedBox(height: 26),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Describe what exactly you did',
                  border: OutlineInputBorder(),
                ),
               minLines: 1,
               maxLines: 10,
              ),

             SizedBox(height: 26),
             SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Log Action',
                    style: TextStyle(
                    ),
                  ),
                ),
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