import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/note_bloc.dart';
import 'notes_screen.dart';

class NotesScreenWrapper extends StatelessWidget {
  const NotesScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        switch (state) {
          case NoteInitial():
            context.read<NoteBloc>().add(LoadNotesFromStorageEvent());
            return const Center(child: CircularProgressIndicator());
          case NoteLoading():
            return const Center(child: CircularProgressIndicator());
          case NoteSuccess():
            return NotesScreen(notes: state.notes);
          case NoteError():
            return const Center(child: Text('Error is bloc'));
        }
      },
    );
  }
}
