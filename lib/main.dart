import 'package:flutter/material.dart';
import 'widgets/mistake_card.dart';
import 'screens/add_mistake_screen.dart';
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
          seedColor: const Color(0xFF7957E8),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF11111B),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> mistakes = const [
    {
      'title': 'Started assignment too late',
      'category': 'Productivity',
      'trigger': 'Scrolling on my phone',
      'solution': 'Start with a 10-minute session',
    },
    {
      'title': 'Forgot to back up code',
      'category': 'Coding',
      'trigger': 'Making changes without committing',
      'solution': 'Commit after every working feature',
    },
    {
      'title': 'Repeated the same coding error',
      'category': 'Learning',
      'trigger': 'Skipping error analysis',
      'solution': 'Write down the cause and fix',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LoopBreak',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.insights),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'BREAK THE LOOP.',
            style: TextStyle(
              fontSize: 13,
              letterSpacing: 2,
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Understand your patterns.',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(
                    Icons.repeat,
                    size: 40,
                    color: Colors.orangeAccent,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${mistakes.length} recorded mistakes',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 5),
                      const Text('Learn from every pattern.'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'YOUR RECENT PATTERNS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          ...mistakes.map(
                (mistake) => MistakeCard(
              title: mistake['title']!,
              category: mistake['category']!,
              trigger: mistake['trigger']!,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMistakeScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Log a mistake'),
            ),
          ),
        ],
      ),
    );
  }
}
