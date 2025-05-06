import 'package:equatable/equatable.dart';

import '../../core/use_case.dart';
import '../repositories/note_repository.dart';

class UpdateNoteUseCase extends UseCaseWithParams<void, UpdateNoteParams> {
  final NoteRepository _repository;

  const UpdateNoteUseCase(this._repository);

  @override
  Future<void> call(UpdateNoteParams params) async =>
      await _repository.deleteNote(params.id);
}

class UpdateNoteParams extends Equatable {
  final int id;

  const UpdateNoteParams({required this.id});

  @override
  List<Object?> get props => [id];
}
