import 'package:flutter/material.dart';
import 'widgets/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

// _ means this state is private (DO THIS FOR ALL PAGES)
class _LoginState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String username_or_email = '';
  //String _password = '';
  bool _passwordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
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
        backgroundColor: AppTheme.ink,
        titleTextStyle: TextStyle(color: AppTheme.bg),
        iconTheme: IconThemeData(color: AppTheme.bg),
        title: const Text('Green Habits'),
        leading: const Icon(Icons.grass),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Green Habits',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                SizedBox(height: 6),
                Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                ),
                SizedBox(height: 26),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username or Email'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',

                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
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
                      backgroundColor: AppTheme.ink,
                      foregroundColor: AppTheme.bg,
                    ),
                    child: Text('Login', style: TextStyle()),
                  ),
                ),
                // SizedBox(height: 26),
                // Center(
                //     child: Text(
                //       'Forgot Password?',
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //       ),
                //     ),
                // ),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => {
                      Navigator.pushReplacementNamed(context, '/signup'),
                    },
                    child: const Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
