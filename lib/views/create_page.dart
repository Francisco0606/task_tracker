import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Page'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Create Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
