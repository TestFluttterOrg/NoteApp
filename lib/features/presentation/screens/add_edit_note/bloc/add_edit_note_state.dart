import 'package:equatable/equatable.dart';
import 'package:noteapp/features/domain/enum/action_type.dart';
import 'package:noteapp/features/domain/model/note_model.dart';

class AddEditNoteState extends Equatable {
  final ActionType actionType;
  final NoteModel? note;
  final bool isTitleValid;

  const AddEditNoteState({
    this.actionType = ActionType.view,
    this.note,
    this.isTitleValid = true,
  });

  AddEditNoteState copyWith({
    ActionType? actionType,
    NoteModel? note,
    bool? isTitleValid,
  }) =>
      AddEditNoteState(
        actionType: actionType ?? this.actionType,
        note: note ?? this.note,
        isTitleValid: isTitleValid ?? this.isTitleValid,
      );

  @override
  List<Object?> get props => [
        actionType,
        note,
        isTitleValid,
      ];
}
