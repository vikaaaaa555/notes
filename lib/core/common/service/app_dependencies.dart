import 'package:dog_journal/data/repositories/note_repository_impl.dart';
import 'package:dog_journal/domain/repositories/note_repository.dart';
import 'package:dog_journal/domain/use_cases/add_note_use_case.dart';
import 'package:dog_journal/domain/use_cases/delete_note_use_case.dart';
import 'package:dog_journal/domain/use_cases/get_all_notes_use_case.dart';
import 'package:dog_journal/domain/use_cases/update_note_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../../data/data_sources/note_local_data_source.dart';
import '../../../data/models/note_model.dart';

final sl = GetIt.instance;

Future<void> registerAppDependencies() async => await Future.wait([
  _registerExternal(),
  _registerUseCases(),
  _registerRepositories(),
  _registerDataSources(),
]);

Future<void> _registerExternal() async =>
    sl.registerLazySingleton<Box<NoteModel>>(() => Hive.box('notes_box'));

Future<void> _registerUseCases() async =>
    sl
      ..registerLazySingleton(() => AddNoteUseCase(sl()))
      ..registerLazySingleton(() => DeleteNoteUseCase(sl()))
      ..registerLazySingleton(() => GetAllNotesUseCase(sl()))
      ..registerLazySingleton(() => UpdateNoteUseCase(sl()));

Future<void> _registerRepositories() async =>
    sl.registerLazySingleton<NoteRepository>(
      () => NoteRepositoryImpl(localDataSource: sl()),
    );

Future<void> _registerDataSources() async =>
    sl.registerLazySingleton<NoteLocalDataSource>(
      () => NoteLocalDataSourceImpl(notesBox: sl()),
    );
