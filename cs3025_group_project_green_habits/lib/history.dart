import 'package:flutter/material.dart';
import 'widgets/bottomNavigationBar.dart';
import 'widgets/header.dart';


class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryState();
}

class _HistoryState extends State<HistoryPage> {
  String _username = "Alice Brown"; // TODO: Replace with actual username once database is established
  double _textSizeSlider = 20;
  final List<bool> _selectedLangauge = [true, false];
  final List<bool> _selectedTheme = [true, false];
  final List<bool> _selectedSound = [true, false];
  String title = "History";
  String titleFr = "History";

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: HeaderBar(
        title: "History",
        helpText: "This is your history, it details your past actions ",
      ),
      body: Center(
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: .center,
          children: [
             Icon(
              Icons.person_2_outlined,
              size: 60,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            
            // Langauge
            SizedBox(height: 12),
            Text(
              '$_username',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 26),
            Text(
              'Language',
            ),
            ToggleButtons(
                isSelected: _selectedLangauge,
                selectedColor: Theme.of(context).colorScheme.onSecondary, onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _selectedLangauge.length; i++) {
                      _selectedLangauge[i] = i == index;
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.green[700],
                fillColor: Colors.green[200],
                color: Colors.green[400],
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                children: <Widget>[
                  Text('English'),
                  Text('French')]
            ), 
            //Color Theme
            SizedBox(height: 26),
            Text(
              'Color Theme'
            ),
            SizedBox(height: 26),
            ToggleButtons(
                isSelected: _selectedTheme,
                selectedColor: Theme.of(context).colorScheme.onSecondary, onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _selectedTheme.length; i++) {
                      _selectedTheme[i] = i == index;
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.green[700],
                fillColor: Colors.green[200],
                color: Colors.green[400],
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                children: <Widget>[
                  Text('Light Mode'),
                  Text('Dark Mode')]
            ), 
            //Sound
            SizedBox(height: 26),
            Text(
              'Sound'
            ),
            SizedBox(height: 10),
            ToggleButtons(
                isSelected: _selectedSound,
                selectedColor: Theme.of(context).colorScheme.onSecondary, onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _selectedSound.length; i++) {
                      _selectedSound[i] = i == index;
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.green[700],
                fillColor: Colors.green[200],
                color: Colors.green[400],
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                children: <Widget>[
                  Text('Enabled'),
                  Text('Disabled')]
            ), 

            //Text Size Slider
            SizedBox(height: 26),
            Text(
              'TextSize',
            ),
            Slider(
              value: _textSizeSlider,
              min: 10,
              max: 100,
              divisions: 45,
              label: _textSizeSlider.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _textSizeSlider = value;
                });
              },
            ),
            //Logout
             SizedBox(
                width: double.infinity,
                height: 49,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                    ),
                  ),
                ),
              ),
          ],

        ),
      ),
      ),
      ),
       bottomNavigationBar: BottomNavigation (
        currentRoute: "/"
      ),
    );
  }
}
