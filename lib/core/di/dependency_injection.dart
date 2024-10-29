import 'package:get_it/get_it.dart';
import 'package:noteapp/features/data/api/api_service.dart';
import 'package:noteapp/features/data/api/impl/api_service_impl.dart';
import 'package:noteapp/features/data/datasource/impl/shared_pref_datasource_impl.dart';
import 'package:noteapp/features/data/datasource/shared_pref_datasource.dart';
import 'package:noteapp/features/data/repository/note_repository_impl.dart';
import 'package:noteapp/features/domain/repository/note_repository.dart';
import 'package:noteapp/features/presentation/screens/add_edit_note/bloc/add_edit_note_bloc.dart';
import 'package:noteapp/features/presentation/screens/note_list/bloc/note_list_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt vf = GetIt.instance;

Future<void> init() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //API Service
  vf.registerLazySingleton<APIService>(() => APIServiceImpl());

  //Datasource
  vf.registerLazySingleton<SharedPrefDataSource>(
    () => SharedPrefDataSourceImpl(
      sharedPref: sharedPreferences,
    ),
  );

  //Repository
  vf.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(
      sharedPrefDataSource: vf.call(),
      apiService: vf.call(),
    ),
  );

  //BLOC
  vf.registerLazySingleton<NoteListBloc>(
    () => NoteListBloc(
      noteRepository: vf.call(),
    ),
  );
  vf.registerFactory<AddEditNoteBloc>(
    () => AddEditNoteBloc(
      noteRepository: vf.call(),
    ),
  );
}
