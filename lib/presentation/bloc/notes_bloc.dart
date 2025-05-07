import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/note_entity.dart';
import '../../domain/use_cases/add_note_use_case.dart';
import '../../domain/use_cases/delete_note_use_case.dart';
import '../../domain/use_cases/get_all_notes_use_case.dart';
import '../../domain/use_cases/update_note_use_case.dart';

part 'notes_event.dart';

part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final AddNoteUseCase addNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetAllNotesUseCase getAllNotesUseCase;
  final UpdateNoteUseCase updateNoteUseCase;

  NotesBloc({
    required this.addNoteUseCase,
    required this.deleteNoteUseCase,
    required this.getAllNotesUseCase,
    required this.updateNoteUseCase,
  }) : super(const NotesInitial()) {
    on<LoadNotesFromStorageEvent>(_handleLoadNotesFromStorageEvent);
    on<AddNoteEvent>(_handleAddNoteEvent);
    on<DeleteNoteEvent>(_handleDeleteNoteEvent);
    on<UpdateNoteEvent>(_handleUpdateNoteEvent);
  }

  Future<void> _handleLoadNotesFromStorageEvent(
    LoadNotesFromStorageEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesLoading());
    try {
      final notes = await getAllNotesUseCase();
      emit(NotesLoadSuccess(notes: notes));
    } catch (e) {
      emit(const NotesError(message: 'Can\'t load notes from storage'));
    }
  }

  Future<void> _handleAddNoteEvent(
    AddNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesLoading());
    try {
      await addNoteUseCase(
        AddNoteParams(
          title: event.title,
          content: event.content,
          image: event.image,
        ),
      );
      add(LoadNotesFromStorageEvent());
    } catch (e) {
      emit(const NotesError(message: 'Failed to add a note'));
    }
  }

  Future<void> _handleDeleteNoteEvent(
    DeleteNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesLoading());
    try {
      await deleteNoteUseCase(DeleteNoteParams(id: event.id));
      add(LoadNotesFromStorageEvent());
    } catch (e) {
      emit(const NotesError(message: 'Failed to delete a note'));
    }
  }

  Future<void> _handleUpdateNoteEvent(
    UpdateNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesLoading());
    try {
      await updateNoteUseCase(
        UpdateNoteParams(
          id: event.id,
          title: event.title,
          content: event.content,
          image: event.image,
        ),
      );
      add(LoadNotesFromStorageEvent());
    } catch (e) {
      emit(const NotesError(message: 'Failed to update a note'));
    }
  }
}
