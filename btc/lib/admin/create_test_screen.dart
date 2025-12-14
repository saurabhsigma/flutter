import 'package:flutter/material.dart';

class CreateTestScreen extends StatefulWidget {
  const CreateTestScreen({super.key});

  @override
  State<CreateTestScreen> createState() => _CreateTestScreenState();
}

class _CreateTestScreenState extends State<CreateTestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questions = <Map<String, dynamic>>[];

  void _addQuestion() {
    setState(() {
      _questions.add({
        'question': '',
        'options': ['', '', '', ''],
        'correct': 0,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Test')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Test Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton.icon(
                  onPressed: _addQuestion,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Question'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_questions.isEmpty)
              const Center(child: Text('No questions added yet.', style: TextStyle(color: Colors.grey))),
            ..._questions.asMap().entries.map((entry) {
              final index = entry.key;
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Question ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Question Text'),
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(4, (optIndex) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Option ${optIndex + 1}'),
                        ),
                      )),
                      DropdownButtonFormField<int>(
                        decoration: const InputDecoration(labelText: 'Correct Option Index (0-3)'),
                        items: const [
                          DropdownMenuItem(value: 0, child: Text('Option 1')),
                          DropdownMenuItem(value: 1, child: Text('Option 2')),
                          DropdownMenuItem(value: 2, child: Text('Option 3')),
                          DropdownMenuItem(value: 3, child: Text('Option 4')),
                        ],
                        onChanged: (v) {},
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Test Saved (Mock)')));
                 Navigator.pop(context);
              },
              child: const Text('Save Test'),
            ),
          ],
        ),
      ),
    );
  }
}
