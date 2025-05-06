import 'package:hive/hive.dart';

import '../../domain/entities/note_entity.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final String image;

  const NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
  });

  factory NoteModel.fromEntity(NoteEntity entity) => NoteModel(
    id: entity.id,
    title: entity.title,
    content: entity.content,
    image: entity.image,
  );

  NoteEntity toEntity() =>
      NoteEntity(id: id, title: title, content: content, image: image);
}
