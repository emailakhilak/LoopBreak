import 'package:flutter/material.dart';
import '../mistake.dart';
import 'add_mistake_screen.dart';

class MistakeDetailScreen extends StatefulWidget {
  final Mistake mistake;

  const MistakeDetailScreen({super.key, required this.mistake});

  @override
  State<MistakeDetailScreen> createState() => _MistakeDetailScreenState();
}

class _MistakeDetailScreenState extends State<MistakeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final mistake = widget.mistake;

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
          FilledButton.icon(
            onPressed: () {
              setState(() {
                mistake.occurrenceCount++;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Recurrence recorded!')),
              );
            },
            icon: const Icon(Icons.repeat),
            label: const Text('It happened again'),
          ),
          const SizedBox(height: 12),
          _section(
            'Status',
            mistake.isResolved ? 'Resolved' : 'Needs improvement',
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () async {
              final original = widget.mistake;

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddMistakeScreen(
                    existingMistake: original,
                    onSave: (updated) {
                      original
                        ..title = updated.title
                        ..trigger = updated.trigger
                        ..consequence = updated.consequence
                        ..solution = updated.solution
                        ..category = updated.category
                        ..isResolved = updated.isResolved;
                    },
                  ),
                ),
              );

              if (context.mounted) setState(() {});
            },
            icon: const Icon(Icons.edit),
            label: const Text('Edit mistake'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Delete mistake?'),
                  content: const Text('This action cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        Navigator.pop(context, true);
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete_outline),
            label: const Text('Delete mistake'),
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
