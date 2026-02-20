import 'package:flutter/material.dart';
import 'widgets/theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

// _ means this state is private (DO THIS FOR ALL PAGES)
class _SignUpState extends State<SignUpPage> {
  final _usernameTextbox = TextEditingController();
  final _passwordTextbox = TextEditingController();
  String usernameOrEmail = '';
  String password = '';
  bool _isPasswordVisible = true; 

  @override
  void dispose() {
    _usernameTextbox.dispose();
    _passwordTextbox.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('Green Habits'),
        leading: const Icon(Icons.grass),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.question_mark_outlined), onPressed: () {}),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Green Habits',
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  //fontSize: 26,
                  //color: Color(0xFF1C1C1C),
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Login',
                style: TextStyle(
                  //fontWeight: FontWeight.normal,
                  //fontSize: 18,
                  //color: Color(0xFF1C1C1C),
                ),
              ),
              SizedBox(height: 26),
              TextField(
                controller: _usernameTextbox,
                decoration: InputDecoration(
                  labelText: 'Username or Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordTextbox,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: _isPasswordVisible,
              ),
              SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                height: 49,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 59, 255, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      //color: Colors.white,
                      //fontSize: 16,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 26),
              Center(
                  child: Text(
                    'Forgot Password?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //fontSize: 14,
                      //color: Color(0xFF87879D),
                    ),
                  ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    //fontSize: 14,
                    //color: Color(0xFF87879D),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}