import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/notes_bloc.dart';
import '../note_form.dart';

class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    return NoteForm(
      onSubmit: (title, content, imagePath) {
        context.read<NotesBloc>().add(
          AddNoteEvent(title: title, content: content, image: imagePath),
        );
        Navigator.pop(context);
      },
    );
  }
}
