import 'package:hive/hive.dart';

import '../../domain/entities/note_entity.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String content;
  @HiveField(2)
  String image;

  NoteModel({required this.title, required this.content, required this.image});

  factory NoteModel.fromEntity(NoteEntity entity) => NoteModel(
    title: entity.title,
    content: entity.content,
    image: entity.image,
  );

  NoteEntity toEntity() =>
      NoteEntity(id: key as int, title: title, content: content, image: image);
}
