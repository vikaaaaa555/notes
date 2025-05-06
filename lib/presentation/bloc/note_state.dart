part of 'note_bloc.dart';

sealed class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object?> get props => [];
}

final class NoteInitial extends NoteState {
  const NoteInitial();
}

final class NoteLoading extends NoteState {
  const NoteLoading();
}

final class NoteSuccess extends NoteState {
  final List<NoteEntity?> notes;

  const NoteSuccess({required this.notes});

  @override
  List<Object?> get props => [notes];
}

final class NoteError extends NoteState {
  final String message;

  const NoteError({required this.message});

  @override
  List<Object?> get props => [message];
}