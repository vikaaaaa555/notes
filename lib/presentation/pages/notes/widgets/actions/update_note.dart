import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../features/domain/entities/note_entity.dart';
import '../../../../bloc/notes_bloc.dart';
import '../note_form.dart';

class UpdateNote extends StatelessWidget {
  final NoteEntity note;

  const UpdateNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return NoteForm(
      initialTitle: note.title,
      initialContent: note.content,
      initialImagePath: note.image,
      onSubmit: (title, content, imagePath) {
        context.read<NotesBloc>().add(
          UpdateNoteEvent(
            id: note.id,
            title: title,
            content: content,
            image: imagePath,
          ),
        );
        Navigator.pop(context);
      },
    );
  }
}
