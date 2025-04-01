import 'package:flutter/material.dart';

class ChuckJokeDetailView extends StatelessWidget {
  final String joke;

  const ChuckJokeDetailView({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del Chiste')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          joke,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
