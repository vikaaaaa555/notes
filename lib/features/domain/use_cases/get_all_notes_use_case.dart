import '../../../core/use_case.dart';
import '../entities/note_entity.dart';
import '../repositories/note_repository.dart';

class GetAllNotesUseCase extends UseCaseWithoutParams<List<NoteEntity>> {
  final NoteRepository _repository;

  const GetAllNotesUseCase(this._repository);

  @override
  Future<List<NoteEntity>> call() async => await _repository.getAllNotes();
}
