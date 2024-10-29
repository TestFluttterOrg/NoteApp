import 'package:noteapp/features/domain/entity/note_entity.dart';
import 'package:noteapp/features/domain/model/result_model.dart';

abstract class APIService {
  Future<ResultModel<List<NoteEntity>>> fetchNotes();

  Future<ResultModel<NoteEntity>> addNote(NoteEntity note);

  Future<void> deleteNote(String noteId);

  Future<void> updateNote(NoteEntity note);
}