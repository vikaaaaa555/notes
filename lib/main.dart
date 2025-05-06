import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'app.dart';
import 'core/common/service/app_dependencies.dart';
import 'data/models/note_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await registerAppDependencies();

  final applicatonDocumentDir =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(applicatonDocumentDir.path);
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>('notes_box');

  runApp(MaterialApp(home: MyApp()));
}
