import 'package:flutter/material.dart';
import '../mistake.dart';

class AddMistakeScreen extends StatefulWidget {
  final ValueChanged<Mistake> onSave;
  final Mistake? existingMistake;

  const AddMistakeScreen({
    super.key,
    required this.onSave,
    this.existingMistake,
  });

  @override
  State<AddMistakeScreen> createState() => _AddMistakeScreenState();
}

class _AddMistakeScreenState extends State<AddMistakeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _triggerController = TextEditingController();
  final _consequenceController = TextEditingController();
  final _solutionController = TextEditingController();

  String _category = 'Productivity';

  final List<String> _categories = [
    'Productivity',
    'Coding',
    'Learning',
    'Communication',
    'Health',
    'Finance',
    'Relationships',
    'Other',
  ];

  @override
  void initState() {
    super.initState();

    final mistake = widget.existingMistake;
    if (mistake != null) {
      _titleController.text = mistake.title;
      _triggerController.text = mistake.trigger;
      _consequenceController.text = mistake.consequence;
      _solutionController.text = mistake.solution;
      _category = mistake.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _triggerController.dispose();
    _consequenceController.dispose();
    _solutionController.dispose();
    super.dispose();
  }

  void _saveMistake() {
    if (!_formKey.currentState!.validate()) return;

    final existing = widget.existingMistake;

    final mistake = Mistake(
      title: _titleController.text.trim(),
      trigger: _triggerController.text.trim(),
      consequence: _consequenceController.text.trim(),
      solution: _solutionController.text.trim(),
      category: _category,
      createdAt: existing?.createdAt ?? DateTime.now(),
      occurrenceCount: existing?.occurrenceCount ?? 1,
      isResolved: existing?.isResolved ?? false,
    );

    widget.onSave(mistake);
    Navigator.pop(context);
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.existingMistake == null ? 'Log a Mistake' : 'Edit Mistake',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Understand what happened.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Every repeated mistake has a pattern.'),
            const SizedBox(height: 24),
            _buildField(
              label: 'Mistake title',
              controller: _titleController,
              hint: 'e.g. Started assignment too late',
            ),
            _buildField(
              label: 'Trigger',
              controller: _triggerController,
              hint: 'What caused it?',
              maxLines: 2,
            ),
            _buildField(
              label: 'Consequence',
              controller: _consequenceController,
              hint: 'What happened as a result?',
              maxLines: 2,
            ),
            _buildField(
              label: 'Solution',
              controller: _solutionController,
              hint: 'What will you do differently?',
              maxLines: 2,
            ),
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: _categories
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _category = value);
                }
              },
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _saveMistake,
              icon: const Icon(Icons.check),
              label: const Text('Validate mistake'),
            ),
          ],
        ),
      ),
    );
  }
}
