part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object?> get props => [];
}

final class LoadNotesFromStorageEvent extends NoteEvent {
  const LoadNotesFromStorageEvent();
}

final class AddNoteEvent extends NoteEvent {
  final String title;
  final String content;
  final String image;

  const AddNoteEvent({
    required this.title,
    required this.content,
    required this.image,
  });

  @override
  List<Object?> get props => [title, content, image];
}

final class DeleteNoteEvent extends NoteEvent {
  final int id;

  const DeleteNoteEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

final class UpdateNoteEvent extends NoteEvent {
  final int id;
  final String? title;
  final String? content;
  final String? image;

  const UpdateNoteEvent({
    required this.id,
    this.title,
    this.content,
    this.image,
  });

  @override
  List<Object?> get props => [id, title, content, image];
}
