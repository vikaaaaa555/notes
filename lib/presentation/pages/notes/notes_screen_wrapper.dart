import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/notes_bloc.dart';
import 'notes_screen.dart';

class NotesScreenWrapper extends StatelessWidget {
  const NotesScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesBloc, NotesState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        switch (state) {
          case NotesInitial():
            context.read<NotesBloc>().add(LoadNotesFromStorageEvent());
            return const Center(child: CircularProgressIndicator());
          case NotesLoading():
            return const Center(child: CircularProgressIndicator());
          case NotesLoadSuccess():
            return NotesScreen(notes: state.notes);
          case NotesError():
            return const Center(child: Text('Error is bloc'));
        }
      },
    );
  }
}
