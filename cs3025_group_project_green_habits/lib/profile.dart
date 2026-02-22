import 'package:flutter/material.dart';
import 'widgets/bottomNavigationBar.dart';
import 'widgets/header.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  String _username = "Alice Brown"; // TODO: Replace with actual username once database is established
  String _email = "abrown@unb.ca";
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  int _score = 100;
  int _coins = 240;
  double _textSizeSlider = 20;
  double textSize = 20;
  final List<bool> _selectedLangauge = [true, false];
  final List<bool> _selectedTheme = [true, false];
  final List<bool> _selectedSound = [true, false];
  

  // @override
  // void initState() {
  //   super.initState();
  //   _usernameController = TextEditingController(text: _username);
  // }

  // @override
  // void dispose() {
  //   _usernameController.dispose();
  //   super.dispose();
  // }


  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: HeaderBar(
        title: "Profile",
        helpText: "This is your profile, you can change your preferences or log out ",
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
            SizedBox(height: 12),
            // Langauge
            Text(
              '$_username ($_email)',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text(
                  '$_score Points',
                  style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(width: 20),
                  Text(
                  '$_coins Coins',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),],),
            SizedBox(height: 26),
            Text(
              'Language',
            ),
            SizedBox(height: 16),
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
            SizedBox(height: 16),
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
              'Sound (Currently Inactive)'
            ),
            SizedBox(height: 16),
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
            // Username Change

            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Change Username", hintText: _username),
            ),
            SizedBox(width: 10, height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Change Email", hintText: _email),
            ),
            SizedBox(width: 10, height: 10),
            ElevatedButton(
              onPressed: () {
                if(_emailController.text.isNotEmpty){
                  print("username changed");
                 _email = _emailController.text;
                }
              },
              child: Text('Save Changes'),
            ),
          




            // Log out
              SizedBox(height: 20),
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
        currentRoute: "/profile"
      ),
    );
  }
}
