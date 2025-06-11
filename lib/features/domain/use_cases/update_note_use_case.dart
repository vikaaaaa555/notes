import 'package:equatable/equatable.dart';

import '../../../core/use_case.dart';
import '../repositories/note_repository.dart';

class UpdateNoteUseCase extends UseCaseWithParams<void, UpdateNoteParams> {
  final NoteRepository _repository;

  const UpdateNoteUseCase(this._repository);

  @override
  Future<void> call(UpdateNoteParams params) async => await _repository
      .updateNote(params.id, params.title, params.content, params.image);
}

class UpdateNoteParams extends Equatable {
  final int id;
  final String? title;
  final String? content;
  final String? image;

  const UpdateNoteParams({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
  });

  @override
  List<Object?> get props => [id, title, content, image];
}
