import '../entities/note_entity.dart';

abstract class NoteRepository {
  const NoteRepository();

  Future<List<NoteEntity>> getAllNotes();

  Future<void> addNote(int id, String title, String content, String image);

  Future<void> deleteNote(int id);

  Future<void> updateNote(int id);
}
