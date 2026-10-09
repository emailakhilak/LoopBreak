import 'package:flutter/material.dart';

class MistakeCard extends StatelessWidget {
  final String title;
  final String category;
  final String trigger;
  final VoidCallback? onTap;

  const MistakeCard({
    super.key,
    required this.title,
    required this.category,
    required this.trigger,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(
          child: Icon(Icons.psychology_outlined),
        ),
        title: Text(title),
        subtitle: Text('$category\nTrigger: $trigger'),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
