import 'package:equatable/equatable.dart';
import 'package:noteapp/features/domain/enum/action_type.dart';
import 'package:noteapp/features/domain/model/note_model.dart';

class AddEditNoteState extends Equatable {
  final ActionType actionType;
  final NoteModel? note;

  const AddEditNoteState({
    this.actionType = ActionType.view,
    this.note,
  });

  AddEditNoteState copyWith({
    ActionType? actionType,
    NoteModel? note,
  }) =>
      AddEditNoteState(
        actionType: actionType ?? this.actionType,
        note: note ?? this.note,
      );

  @override
  List<Object?> get props => [
        actionType,
        note,
      ];
}
