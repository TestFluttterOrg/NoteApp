import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/features/domain/repository/note_repository.dart';
import 'package:noteapp/features/presentation/screens/add_edit_note/bloc/add_edit_note_state.dart';

class AddEditNoteBloc extends Cubit<AddEditNoteState> {
  final NoteRepository noteRepository;

  AddEditNoteBloc({
    required this.noteRepository,
  }) : super(const AddEditNoteState());
}
