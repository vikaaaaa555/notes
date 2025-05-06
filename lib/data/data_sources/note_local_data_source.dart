import 'package:hive/hive.dart';

import '../../domain/entities/note_entity.dart';
import '../models/note_model.dart';

abstract class NoteLocalDataSource {
  Future<List<NoteEntity>> getAllNotes();

  Future<void> addNote(String title, String content, String image);

  Future<void> deleteNote(int id);

  Future<void> updateNote(
    int id,
    String? title,
    String? content,
    String? image,
  );
}

class NoteLocalDataSourceImpl extends NoteLocalDataSource {
  final Box<NoteModel> notesBox;

  NoteLocalDataSourceImpl({required this.notesBox});

  @override
  Future<void> addNote(String title, String content, String image) async {
    final note = NoteModel(title: title, content: content, image: image);
    await notesBox.add(note);
  }

  @override
  Future<void> deleteNote(int id) async => await notesBox.delete(id);

  @override
  Future<List<NoteEntity>> getAllNotes() async {
    final notes = notesBox.values.toList();
    return notes.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateNote(
    int id,
    String? title,
    String? content,
    String? image,
  ) async {
    final note = notesBox.get(id);
    if (note != null) {
      if (title != null) note.title = title;
      if (content != null) note.content = content;
      if (image != null) note.image = image;
      await note.save();
    } else {
      throw Exception('Note with id $id not found');
    }
  }
}
