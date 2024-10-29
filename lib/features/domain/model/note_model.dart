import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final String id;
  final String title;
  final String content;

  const NoteModel({
    this.id = "",
    this.title = "",
    this.content = "",
  });

  @override
  List<Object?> get props => [
        id,
        title,
        content,
      ];
}
