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
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Login',
                style: TextStyle(
                  //fontWeight: FontWeight.normal,
                  //fontSize: 18,
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      //fontSize: 16,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Go back to Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    //fontSize: 14,
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