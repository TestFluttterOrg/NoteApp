import 'package:either_dart/src/either.dart';
import 'package:noteapp/features/data/api/api_service.dart';
import 'package:noteapp/features/data/datasource/shared_pref_datasource.dart';
import 'package:noteapp/features/domain/entity/note_entity.dart';
import 'package:noteapp/features/domain/mapper/note_entity_extension.dart';
import 'package:noteapp/features/domain/model/failed_model.dart';
import 'package:noteapp/features/domain/model/note_model.dart';
import 'package:noteapp/features/domain/model/success_model.dart';
import 'package:noteapp/features/domain/repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final APIService apiService;
  final SharedPrefDataSource sharedPrefDataSource;

  NoteRepositoryImpl({
    required this.apiService,
    required this.sharedPrefDataSource,
  });

  @override
  Future<Either<FailedModel, SuccessModel<NoteModel>>> addNote({
    required String title,
    required String content,
  }) async {
    final data = NoteEntity(title: title, content: content);
    final result = await apiService.addNote(data);
    if (result.isSuccess) {
      final noteData = result.data?.mapToNoteModel() ?? const NoteModel();
      return Right(
        SuccessModel(
          message: result.message,
          data: noteData,
        ),
      );
    } else {
      return Left(FailedModel(message: result.message));
    }
  }

  @override
  Future<Either<FailedModel, SuccessModel>> deleteNote({
    required String id,
  }) async {
    final result = await apiService.deleteNote(id);
    if (result.isSuccess) {
      return Right(SuccessModel(message: result.message));
    } else {
      return Left(FailedModel(message: result.message));
    }
  }

  @override
  Future<Either<FailedModel, SuccessModel<NoteModel>>> editNote({
    required NoteModel note,
  }) async {
    final data = NoteEntity(id: note.id, title: note.title, content: note.content);
    final result = await apiService.updateNote(data);
    if (result.isSuccess) {
      final noteData = result.data?.mapToNoteModel() ?? const NoteModel();
      return Right(
        SuccessModel(
          message: result.message,
          data: noteData,
        ),
      );
    } else {
      return Left(FailedModel(message: result.message));
    }
  }

  @override
  Future<Either<FailedModel, SuccessModel<List<NoteModel>>>> getAllNotes() async {
    final result = await apiService.fetchNotes();
    if (result.isSuccess) {
      final data = result.data ?? [];

      //map the data from entity to model
      final noteList = data.map((e) => e.mapToNoteModel()).toList();

      return Right(SuccessModel(data: noteList));
    } else {
      return Left(FailedModel(message: result.message));
    }
  }
}
