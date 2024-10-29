import 'package:noteapp/features/domain/entity/note_entity.dart';
import 'package:noteapp/features/domain/model/note_model.dart';

extension NoteEntityExtension on NoteEntity {
  NoteModel mapToNoteModel() {
    final data = this;
    return NoteModel(
      id: data.id ?? "",
      title: data.title ?? "",
      content: data.content ?? "",
      createdAt: data.createdAt,
    );
  }
}
