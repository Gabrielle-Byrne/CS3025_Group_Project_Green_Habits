import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/bottomNavigationBar.dart';


class GardenPage extends StatefulWidget {
  const GardenPage({super.key});

  @override
  State<GardenPage> createState() => _GardenState();
}

class _GardenState extends State<GardenPage> {
  String _title = "Garden"; // TODO: Replace with actual username once database is established

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        title: "Garden",
        helpText: "This is your garden, you can use points earned from your actions to purchase virtural plants",
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
             Text(
              '$_title',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            // ADD GARDEN HERE
            //Images 

            SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/garden-store');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Go to Store',
                    style: TextStyle(
                    ),
                  ),
                ),
              ),
          ],
          
        ),
      ),
       bottomNavigationBar: BottomNavigation (
        currentRoute: "/garden"
      ),
    );
  }
}
