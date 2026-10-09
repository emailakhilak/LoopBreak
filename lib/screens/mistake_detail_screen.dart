import 'package:flutter/material.dart';
import '../mistake.dart';

class MistakeDetailScreen extends StatelessWidget {
  final Mistake mistake;

  const MistakeDetailScreen({super.key, required this.mistake});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mistake Details')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            mistake.title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Chip(label: Text(mistake.category)),
          const SizedBox(height: 20),
          _section('Trigger', mistake.trigger),
          _section('Consequence', mistake.consequence),
          _section('Solution', mistake.solution),
          _section('Occurrences', '${mistake.occurrenceCount}'),
          _section(
            'Status',
            mistake.isResolved ? 'Resolved' : 'Needs improvement',
          ),
        ],
      ),
    );
  }

  Widget _section(String title, String content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}
