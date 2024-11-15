import 'package:flutter/material.dart';
import 'package:task_tracker/services/database_helper.dart';
import 'package:task_tracker/views/main_page.dart';
import 'package:task_tracker/views/signup_page.dart';
import 'package:task_tracker/views/forgot_pass_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Method to validate login credentials
  void _login() async {
    final String usernameOrEmail = _usernameController.text;
    final String password = _passwordController.text;

    if (usernameOrEmail.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter both username/email and password')),
      );
      return;
    }

    // Validate user credentials
    int? userId =
        await _databaseHelper.validateUserLogin(usernameOrEmail, password);

    if (userId != null) {
      // If login is successful, navigate to the MainPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage(userId: userId)),
      );
    } else {
      // Show error message if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username/email or password')),
      );
    }
  }

  void _navigateToSignupPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupPage()),
    );
  }

  void _navigateToForgotPassPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPassPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Username/email input
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Email/Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Password input
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            // Login button
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Log In'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _navigateToSignupPage,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: _navigateToForgotPassPage,
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.blue[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
