import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime? createdAt;

  const NoteModel({
    this.id = "",
    this.title = "",
    this.content = "",
    this.createdAt,
  });

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
  }) =>
      NoteModel(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        createdAt,
      ];
}
