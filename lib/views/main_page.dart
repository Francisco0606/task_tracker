import 'package:flutter/material.dart';
import 'create_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.userId});
  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Center(
        child: Text(
          'Welcome $userId',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePage()),
          );
        },
        tooltip: 'Create',
        child: const Icon(
          Icons.add,
        ), // "+" icon
      ),
    );
  }
}
