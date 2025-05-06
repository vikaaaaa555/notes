import 'package:dog_journal/presentation/bloc/note_bloc.dart';
import 'package:dog_journal/presentation/pages/notes/notes_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/common/service/app_dependencies.dart';
import 'domain/use_cases/add_note_use_case.dart';
import 'domain/use_cases/delete_note_use_case.dart';
import 'domain/use_cases/get_all_notes_use_case.dart';
import 'domain/use_cases/update_note_use_case.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      create:
          (context) => NoteBloc(
            addNoteUseCase: sl<AddNoteUseCase>(),
            deleteNoteUseCase: sl<DeleteNoteUseCase>(),
            getAllNotesUseCase: sl<GetAllNotesUseCase>(),
            updateNoteUseCase: sl<UpdateNoteUseCase>(),
          ),
      child: MaterialApp(home: NotesScreenWrapper()),
    );
  }
}
