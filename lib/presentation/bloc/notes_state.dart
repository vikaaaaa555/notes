part of 'notes_bloc.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object?> get props => [];
}

final class NotesInitial extends NotesState {
  const NotesInitial();
}

final class NotesLoading extends NotesState {
  const NotesLoading();
}

final class NotesLoadSuccess extends NotesState {
  final List<NoteEntity?> notes;

  const NotesLoadSuccess({required this.notes});

  @override
  List<Object?> get props => [notes];
}

final class NotesError extends NotesState {
  final String message;

  const NotesError({required this.message});

  @override
  List<Object?> get props => [message];
}