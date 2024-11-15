import 'package:flutter/material.dart';
import 'package:task_tracker/views/forgot_pass_page.dart';
import 'package:task_tracker/views/signup_page.dart';
import 'views/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _navigateToMainPage() {
    int userId = 1;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage(userId: userId)),
    );
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
            // Username input
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
              onPressed: _navigateToMainPage,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Log In'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: _navigateToSignupPage,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Sign Up'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextButton(
                onPressed: _navigateToForgotPassPage,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blue[700]),
                ))
          ],
        ),
      ),
    );
  }
}
