import 'package:noteapp/features/domain/entity/note_entity.dart';
import 'package:noteapp/features/domain/model/result_model.dart';

abstract class APIService {
  Future<ResultModel<List<NoteEntity>>> fetchNotes();

  Future<ResultModel<NoteEntity>> addNote(NoteEntity note);

  Future<ResultModel> deleteNote(String noteId);

  Future<ResultModel<NoteEntity>> updateNote(NoteEntity note);
}