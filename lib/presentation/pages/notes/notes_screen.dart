import 'package:dog_journal/presentation/pages/notes/widgets/actions/add_note.dart';
import 'package:dog_journal/presentation/pages/notes/widgets/actions/update_note.dart';
import 'package:dog_journal/presentation/pages/notes/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/domain/entities/note_entity.dart';
import '../../bloc/notes_bloc.dart';

class NotesScreen extends StatefulWidget {
  final List<NoteEntity?> notes;

  const NotesScreen({super.key, required this.notes});

  @override
  State<StatefulWidget> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  void _showOptionsDialog(NoteEntity note) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed:
                          () => showModalBottomSheet(
                            context: context,
                            builder:
                                (context) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: UpdateNote(note: note),
                                ),
                          ),
                      child: Text('Update'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<NotesBloc>().add(
                          DeleteNoteEvent(id: note.id),
                        );
                        Navigator.pop(context);
                      },
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
        scrolledUnderElevation: 0.0,
      ),
      body:
          widget.notes.isNotEmpty
              ? Padding(
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: widget.notes.length,
                  itemBuilder: (context, index) {
                    final note = widget.notes[index];
                    return GestureDetector(
                      onLongPress: () => _showOptionsDialog(note),
                      child: NoteCard(
                        title: note!.title,
                        content: note.content,
                        image: note.image,
                      ),
                    );
                  },
                ),
              )
              : const SizedBox(),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => showModalBottomSheet(
              context: context,
              builder:
                  (context) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AddNote(),
                  ),
            ),
        child: Icon(Icons.note_add_rounded),
      ),
    );
  }
}
