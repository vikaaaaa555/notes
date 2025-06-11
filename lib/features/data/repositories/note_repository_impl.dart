import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/note_repository.dart';
import '../data_sources/note_local_data_source.dart';

class NoteRepositoryImpl extends NoteRepository {
  final NoteLocalDataSource localDataSource;

  const NoteRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addNote(String title, String content, String image) async =>
      await localDataSource.addNote(title, content, image);

  @override
  Future<void> deleteNote(int id) async => await localDataSource.deleteNote(id);

  @override
  Future<List<NoteEntity>> getAllNotes() async =>
      await localDataSource.getAllNotes();

  @override
  Future<void> updateNote(
    int id,
    String? title,
    String? content,
    String? image,
  ) async => await localDataSource.updateNote(id, title, content, image);
}
