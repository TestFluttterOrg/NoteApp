import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noteapp/features/domain/entity/note_entity.dart';

part 'note_list_entity.g.dart';

part 'note_list_entity.freezed.dart';

@freezed
class NoteListEntity with _$NoteListEntity {
  factory NoteListEntity({
    required List<NoteEntity> data,
  }) = _NoteListEntity;

  factory NoteListEntity.fromJson(Map<String, dynamic> json) => _$NoteListEntityFromJson(json);
}
