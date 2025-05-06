import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/note_entity.dart';
import '../../domain/use_cases/add_note_use_case.dart';
import '../../domain/use_cases/delete_note_use_case.dart';
import '../../domain/use_cases/get_all_notes_use_case.dart';
import '../../domain/use_cases/update_note_use_case.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final AddNoteUseCase addNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetAllNotesUseCase getAllNotesUseCase;
  final UpdateNoteUseCase updateNoteUseCase;

  NoteBloc({
    required this.addNoteUseCase,
    required this.deleteNoteUseCase,
    required this.getAllNotesUseCase,
    required this.updateNoteUseCase,
  }) : super(const NoteInitial()) {
    on<LoadNotesFromStorageEvent>(_handleLoadNotesFromStorageEvent);
    on<AddNoteEvent>(_handleAddNoteEvent);
    on<DeleteNoteEvent>(_handleDeleteNoteEvent);
    on<UpdateNoteEvent>(_handleUpdateNoteEvent);
  }

  Future<void> _handleLoadNotesFromStorageEvent(
    LoadNotesFromStorageEvent event,
    Emitter<NoteState> emit,
  ) async {
    emit(const NoteLoading());
    try {
      final notes = await getAllNotesUseCase();
      emit(NoteSuccess(notes: notes));
    } catch (e) {
      emit(const NoteError(message: 'Can\'t load notes from storage'));
    }
  }

  Future<void> _handleAddNoteEvent(
    AddNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    emit(const NoteLoading());
    try {
      await addNoteUseCase(
        AddNoteParams(
          title: event.title,
          content: event.content,
          image: event.image,
        ),
      );
    } catch (e) {
      emit(const NoteError(message: 'Failed to add a note'));
    }
  }

  Future<void> _handleDeleteNoteEvent(
    DeleteNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    emit(const NoteLoading());
    try {
      await deleteNoteUseCase(DeleteNoteParams(id: event.id));
    } catch (e) {
      emit(const NoteError(message: 'Failed to delete a note'));
    }
  }

  Future<void> _handleUpdateNoteEvent(
    UpdateNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    emit(const NoteLoading());
    try {
      await updateNoteUseCase(
        UpdateNoteParams(
          id: event.id,
          title: event.title,
          content: event.content,
          image: event.image,
        ),
      );
    } catch (e) {
      emit(const NoteError(message: 'Failed to update a note'));
    }
  }
}
