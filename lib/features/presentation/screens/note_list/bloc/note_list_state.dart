import 'package:equatable/equatable.dart';
import 'package:noteapp/features/domain/model/note_model.dart';

abstract class NoteListState extends Equatable {}

class NoteListInitialState extends NoteListState {
  @override
  List<Object?> get props => [];
}

class NoteListLoadingState extends NoteListState {
  @override
  List<Object?> get props => [];
}

class NoteListLoadedState extends NoteListState {
  final List<NoteModel> noteList;

  NoteListLoadedState({
    required this.noteList,
  });

  @override
  List<Object?> get props => [
        noteList,
      ];
}

class NoteListErrorState extends NoteListState {
  final String message;

  NoteListErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
