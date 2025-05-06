import 'package:equatable/equatable.dart';

import '../../core/use_case.dart';
import '../repositories/note_repository.dart';

class DeleteNoteUseCase extends UseCaseWithParams<void, DeleteNoteParams> {
  final NoteRepository _repository;

  const DeleteNoteUseCase(this._repository);

  @override
  Future<void> call(DeleteNoteParams params) async =>
      await _repository.deleteNote(params.id);
}

class DeleteNoteParams extends Equatable {
  final int id;

  const DeleteNoteParams({required this.id});

  @override
  List<Object?> get props => [id];
}
