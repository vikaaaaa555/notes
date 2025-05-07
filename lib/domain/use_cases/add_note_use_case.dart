import 'package:equatable/equatable.dart';

import '../../core/use_case.dart';
import '../repositories/note_repository.dart';

class AddNoteUseCase extends UseCaseWithParams<void, AddNoteParams> {
  final NoteRepository _repository;

  const AddNoteUseCase(this._repository);

  @override
  Future<void> call(AddNoteParams params) async =>
      await _repository.addNote(params.title, params.content, params.image);
}

class AddNoteParams extends Equatable {
  final String title;
  final String content;
  final String image;

  const AddNoteParams({
    required this.title,
    required this.content,
    required this.image,
  });

  @override
  List<Object?> get props => [title, content, image];
}
