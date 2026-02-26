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
      (CategoryLabel category) => CategoryEntry(
        value: category,
        label: category.label,
        leadingIcon: Icon(category.icon),
      ),
    ),
  );
}


class _TipsState extends State<TipsPage> {
  String _title = "Tips";
  final TextEditingController categoryController = TextEditingController();
  CategoryLabel? selectedCategory;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        title: "Tips",
        //showTipsButton: false,
        helpText: "This is the Tips Page, you can learn facts about plants",
      ),
      body: Center(
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: .center,
          children: [
             Text(
              '$_title',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height:12),
            // ADD Tips HERE
              DropdownMenu<CategoryLabel>(
                        controller: categoryController,
                        enableFilter: true,
                        requestFocusOnTap: true,
                        leadingIcon: const Icon(Icons.search),
                        label: const Text('Category'),
                        inputDecorationTheme: const InputDecorationTheme(
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        ),
                        onSelected: (CategoryLabel? icon) {
                          setState(() {
                            selectedCategory = icon;
                          });
                        },
                        dropdownMenuEntries: CategoryLabel.entries,
                      ), 

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
      ),
       bottomNavigationBar: BottomNavigation (
        currentRoute: "/tips"
      ),
    );
  }
}
