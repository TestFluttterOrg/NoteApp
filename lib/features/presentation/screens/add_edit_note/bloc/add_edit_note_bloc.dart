import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/features/presentation/screens/add_edit_note/bloc/add_edit_note_state.dart';

class AddEditNoteBloc extends Cubit<AddEditNoteState> {
  AddEditNoteBloc() : super(const AddEditNoteState());
}