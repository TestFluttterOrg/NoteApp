import 'package:noteapp/features/domain/entity/note_entity.dart';
import 'package:noteapp/features/domain/model/note_model.dart';

extension NoteModelExtension on NoteModel {
  NoteEntity mapToNoteEntity() {
    final data = this;
    return NoteEntity(
      id: data.id,
      title: data.title,
      content: data.content,
      createdAt: data.createdAt,
    );
  }
}
