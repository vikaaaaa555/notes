import 'package:hive/hive.dart';

import '../../domain/entities/note_entity.dart';
import '../models/note_model.dart';

abstract class NoteLocalDataSource {
  Future<List<NoteEntity>> getAllNotes();

  Future<void> addNote(int id, String title, String content, String image);

  Future<void> deleteNote(int id);

  Future<void> updateNote(
    int id,
    String? title,
    String? content,
    String? image,
  );
}

class NoteLocalDataSourceImpl extends NoteLocalDataSource {
  final Box<NoteModel> _notesBox;

  NoteLocalDataSourceImpl(this._notesBox);

  @override
  Future<void> addNote(
    int id,
    String title,
    String content,
    String image,
  ) async {
    final note = NoteModel(
      id: id,
      title: title,
      content: content,
      image: image,
    );
    await _notesBox.put(id, note);
  }

  @override
  Future<void> deleteNote(int id) async => await _notesBox.delete(id);

  @override
  Future<List<NoteEntity>> getAllNotes() async {
    final notes = _notesBox.values.toList();
    return notes.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateNote(
    int id,
    String? title,
    String? content,
    String? image,
  ) async {
    final note = _notesBox.get(id);
    if (note != null) {
      final updatedNote = NoteModel(
        id: note.id,
        title: title ?? note.title,
        content: content ?? note.content,
        image: image ?? note.image,
      );
      await _notesBox.put(id, updatedNote);
    }
  }
}
