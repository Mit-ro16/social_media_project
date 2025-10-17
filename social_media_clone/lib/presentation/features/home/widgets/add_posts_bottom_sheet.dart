import 'package:flutter/material.dart';

class AddPostSheet extends StatefulWidget {
  final Future<void> Function(String title, String content) onSubmit;
  const AddPostSheet({super.key, required this.onSubmit});

  @override
  State<AddPostSheet> createState() => _AddPostSheetState();
}

class _AddPostSheetState extends State<AddPostSheet> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Create Post', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: contentController,
            decoration: const InputDecoration(labelText: 'Content'),
            maxLines: 4,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isLoading
                ? null
                : () async {
                    setState(() => isLoading = true);
                    await widget.onSubmit(
                      titleController.text.trim(),
                      contentController.text.trim(),
                    );
                    setState(() => isLoading = false);
                  },
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Upload Post'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
