import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_entity.freezed.dart';
part 'note_entity.g.dart';

@freezed
class NoteEntity with _$NoteEntity {
  factory NoteEntity({
    @JsonKey(includeToJson: false) String? id,
    String? title,
    String? content,
    @JsonKey(includeToJson: false, fromJson: _fromJson, toJson: _toJson) DateTime? createdAt,
  }) = _NoteEntity;

  factory NoteEntity.fromJson(Map<String, dynamic> json) => _$NoteEntityFromJson(json);
}

DateTime? _fromJson(String? date) => date != null ? DateTime.parse(date) : null;
String? _toJson(DateTime? date) => date?.toIso8601String();

extension NoteEntityExtensions on NoteEntity {
  Map<String, dynamic> toJsonWithIdAndCreated() {
    final json = toJson(); // Calls the default toJson from Freezed
    json['id'] = id;
    json['createdAt'] = createdAt?.toIso8601String();
    return json;
  }
}
