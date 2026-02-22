import 'dart:collection';

import 'package:flutter/material.dart';
//import 'widgets/theme.dart';
import 'widgets/header.dart';
import 'widgets/bottomNavigationBar.dart';


class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsState();
}

typedef CategoryEntry = DropdownMenuEntry<CategoryLabel>;

// DropdownMenuEntry labels and values for the second dropdown menu.
enum CategoryLabel {
  recycing('Recycling', Icons.recycling),
  transit('Sustainable Transit', Icons.directions_bus),
  energy('Energy', Icons.energy_savings_leaf),
  // energy('Brush', Icons.brush_outlined),
  // energy('Brush', Icons.brush_outlined),
  general('Other', Icons.public);

  const CategoryLabel(this.label, this.icon);
  final String label;
  final IconData icon;

  static final List<CategoryEntry> entries = UnmodifiableListView<CategoryEntry>(
    values.map<CategoryEntry>(
      (CategoryLabel icon) => CategoryEntry(
        value: icon,
        label: icon.label,
        leadingIcon: Icon(icon.icon),
      ),
    ),
  );
}


class _TipsState extends State<TipsPage> {
  String _title = "Tips"; // TODO: Replace with actual username once database is established

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        title: "Tips",
        helpText: "This is the Tips Page, you can learn facts about plants",
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
             Text(
              '$_title',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            // ADD Tips HERE
            //Images 

            SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
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
                    'There are...',
                    style: TextStyle(
                    ),
                  ),
                ),
              ),
          ],
          
        ),
      ),
       bottomNavigationBar: BottomNavigation (
        currentRoute: "/tips"
      ),
    );
  }
}
