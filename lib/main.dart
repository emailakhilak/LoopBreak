import 'package:flutter/material.dart';
import 'screens/mistake_detail_screen.dart';
import 'mistake.dart';
import 'screens/add_mistake_screen.dart';
import 'widgets/mistake_card.dart';

void main() {
  runApp(const LoopBreakApp());
}

class LoopBreakApp extends StatelessWidget {
  const LoopBreakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoopBreak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Mistake> _mistakes = [
    Mistake(
      title: 'Started assignment too late',
      trigger: 'Procrastination',
      consequence: 'Rushed submission',
      solution: 'Start with a 15-minute session',
      category: 'Productivity',
      createdAt: DateTime.now(),
    ),
    Mistake(
      title: 'Forgot to test my code',
      trigger: 'Skipping verification',
      consequence: 'Bugs reached the final output',
      solution: 'Run tests before committing',
      category: 'Coding',
      createdAt: DateTime.now(),
    ),
  ];

  void _addMistake(Mistake mistake) {
    setState(() {
      _mistakes.insert(0, mistake);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LoopBreak'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Break the pattern.',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text('Understand your mistakes. Build better habits.'),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Mistakes tracked'),
                    Text(
                      '${_mistakes.length}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _mistakes
                  .map((mistake) => mistake.category)
                  .toSet()
                  .map(
                    (category) => Chip(
                      label: Text(
                        '$category: ${_mistakes.where((m) => m.category == category).length}',
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent mistakes',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddMistakeScreen(onSave: _addMistake),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _mistakes.isEmpty
                  ? const Center(child: Text('No mistakes logged yet.'))
                  : ListView.builder(
                      itemCount: _mistakes.length,
                      itemBuilder: (context, index) {
                        final mistake = _mistakes[index];

                        return MistakeCard(
                          title: mistake.title,
                          category: mistake.category,
                          trigger: mistake.trigger,
                          onTap: () async {
                            final shouldDelete = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    MistakeDetailScreen(mistake: mistake),
                              ),
                            );

                            if (shouldDelete == true && mounted) {
                              setState(() {
                                _mistakes.remove(mistake);
                              });
                            }
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
