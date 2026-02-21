import 'package:flutter/material.dart';
import 'widgets/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

// _ means this state is private (DO THIS FOR ALL PAGES)
class _LoginState extends State<LoginPage> {
  final _usernameTextbox = TextEditingController();
  final _passwordTextbox = TextEditingController();
  String username_or_email = '';
  String _password = '';
  bool _passwordVisible = false; 

  @override
  void dispose() {
    _usernameTextbox.dispose();
    _passwordTextbox.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('Green Habits'),
        leading: const Icon(Icons.grass),
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
                  fontWeight: FontWeight.bold,
                  //fontSize: 26,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Login',
                style: TextStyle(
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
                  suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
                ),
                obscureText: _passwordVisible,
                
              ),
              SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                height: 49,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
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
                    ),
                  ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
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