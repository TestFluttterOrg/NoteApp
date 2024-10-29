import 'package:either_dart/either.dart';
import 'package:noteapp/features/domain/model/failed_model.dart';
import 'package:noteapp/features/domain/model/note_model.dart';
import 'package:noteapp/features/domain/model/success_model.dart';

abstract class NoteRepository {
  Future<Either<FailedModel, SuccessModel<List<NoteModel>>>> getAllNotes();

  Future<Either<FailedModel, SuccessModel<NoteModel>>> addNote({
    required String title,
    required String content,
  });

  Future<Either<FailedModel, SuccessModel<NoteModel>>> editNote({
    required NoteModel note,
  });

  Future<Either<FailedModel, SuccessModel>> deleteNote({
    required String id,
  });
}
