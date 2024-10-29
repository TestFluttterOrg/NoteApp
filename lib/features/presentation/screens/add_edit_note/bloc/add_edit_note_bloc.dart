import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/features/domain/enum/action_type.dart';
import 'package:noteapp/features/domain/model/action_param_model.dart';
import 'package:noteapp/features/domain/repository/note_repository.dart';
import 'package:noteapp/features/presentation/screens/add_edit_note/bloc/add_edit_note_state.dart';

class AddEditNoteBloc extends Cubit<AddEditNoteState> {
  final NoteRepository noteRepository;

  AddEditNoteBloc({
    required this.noteRepository,
  }) : super(const AddEditNoteState());

  void initialize(ActionParamModel action) {
    emit(
      state.copyWith(
        actionType: action.actionType,
        note: action.data,
      ),
    );
  }

  void setAction(ActionType action) {
    emit(state.copyWith(actionType: action));
  }

  void validateTitle(String title) {
    if (title.trim() == "" || title.trim() == " ") {
      emit(state.copyWith(isTitleValid: false));
    } else {
      emit(state.copyWith(isTitleValid: true));
    }
  }

  void save({
    required String title,
    required String content,
  }) async {
    validateTitle(title);
    if (state.isTitleValid) {
      
    }
  }
}
