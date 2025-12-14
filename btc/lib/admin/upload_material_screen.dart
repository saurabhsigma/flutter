import 'package:flutter/material.dart';

class UploadMaterialScreen extends StatelessWidget {
  const UploadMaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Material')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Material Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {},
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload_outlined, size: 50, color: Colors.grey),
                    SizedBox(height: 10),
                    Text('Tap to select PDF'),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Material Uploaded (Mock)')));
                   Navigator.pop(context);
                },
                child: const Text('Upload'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
