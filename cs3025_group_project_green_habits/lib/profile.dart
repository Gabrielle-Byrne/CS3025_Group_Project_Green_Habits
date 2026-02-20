import 'package:flutter/material.dart';
import 'widgets/theme.dart';
import 'widgets/bottomNavigationBar.dart';
import 'widgets/header.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  String _username = "Alice Brown"; // TODO: Replace with actual username once database is established
  double _textSizeSlider = 20;

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: HeaderBar(
        title: "Profile",
        helpText: "This is your profile, you can change your preferences or log out ",
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: .center,
          children: [
             Icon(
              Icons.person_2_outlined,
              size: 60,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            SizedBox(height: 12),
            Text(
              '$_username',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 26),
            Text(
              'Language',
            ),
            ToggleButtons(isSelected: <bool> [true, false],
                selectedColor:  Theme.of(context).colorScheme.onSecondary, children: <Widget>[
              Text('English'),
              Text('French')]), 
            SizedBox(height: 26),
            Text(
              'Language',
            ),
            ToggleButtons(isSelected: <bool> [true, false],
                selectedColor:  Theme.of(context).colorScheme.onSecondary, children: <Widget>[
              Text('Light Mode'),
              Text('Dark Mode')]), 
            SizedBox(height: 26),
            Text(
              'TextSize',
            ),
            Slider(
              // ignore: deprecated_member_use
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
       bottomNavigationBar: BottomNavigation (
        currentRoute: "/profile"
      ),
    );
  }
}
