import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/features/domain/repository/note_repository.dart';
import 'package:noteapp/features/presentation/screens/note_list/bloc/note_list_state.dart';

class NoteListBloc extends Cubit<NoteListState> {
  final NoteRepository noteRepository;

  NoteListBloc({
    required this.noteRepository,
  }) : super(NoteListInitialState());

  void initialize() {

  }
}
