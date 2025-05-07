import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NoteForm extends StatefulWidget {
  final String? initialTitle;
  final String? initialContent;
  final String? initialImagePath;
  final Function(String title, String content, String imagePath) onSubmit;

  const NoteForm({
    super.key,
    this.initialTitle,
    this.initialContent,
    this.initialImagePath,
    required this.onSubmit,
  });

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  File? _image;
  String? _imagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
        _image = File(_imagePath!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _contentController = TextEditingController(
      text: widget.initialContent ?? '',
    );
    _imagePath = widget.initialImagePath;
    if (_imagePath != null) {
      _image = File(_imagePath!);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Title'),
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(hintText: 'Note\'s text'),
              maxLines: 5,
            ),
            const SizedBox(height: 10),
            if (_image != null)
              Image.file(_image!, height: 100, width: 100, fit: BoxFit.cover),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _contentController.text.isNotEmpty &&
                    _imagePath != null) {
                  widget.onSubmit(
                    _titleController.text,
                    _contentController.text,
                    _imagePath!,
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Fill in all fields'),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height - 200,
                        right: 20,
                        left: 20,
                      ),
                    ),
                  );
                }
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
