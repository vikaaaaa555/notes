import 'dart:io';

import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  final String image;

  const NoteCard({
    super.key,
    required this.title,
    required this.content,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(content, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Flexible(
              child: Image.file(
                File(image),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
