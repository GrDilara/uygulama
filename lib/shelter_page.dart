import 'package:flutter/material.dart';

class ShelterPage extends StatelessWidget {
  const ShelterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shelter Page'),
      ),
      body: const Center(
        child: Text('Welcome to the Shelter Page!'),
      ),
    );
  }
}
