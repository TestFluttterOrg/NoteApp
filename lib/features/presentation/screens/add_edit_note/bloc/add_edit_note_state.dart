import 'package:equatable/equatable.dart';
import 'package:noteapp/features/domain/enum/action_type.dart';
import 'package:noteapp/features/domain/model/note_model.dart';
import 'package:noteapp/features/presentation/screens/add_edit_note/bloc/add_edit_note_bloc.dart';

class AddEditNoteState extends Equatable {
  final ActionType actionType;
  final NoteModel? note;
  final bool isTitleValid;
  final String message;
  final AddEditNoteUIEvents event;
  final bool hasUpdate;

  const AddEditNoteState({
    this.actionType = ActionType.view,
    this.note,
    this.isTitleValid = true,
    this.message = "",
    this.event = AddEditNoteUIEvents.initial,
    this.hasUpdate = false,
  });

  AddEditNoteState copyWith({
    ActionType? actionType,
    NoteModel? note,
    bool? isTitleValid,
    String? message,
    AddEditNoteUIEvents? event,
    bool? hasUpdate,
  }) =>
      AddEditNoteState(
        actionType: actionType ?? this.actionType,
        note: note ?? this.note,
        isTitleValid: isTitleValid ?? this.isTitleValid,
        message: message ?? this.message,
        event: event ?? this.event,
        hasUpdate: hasUpdate ?? this.hasUpdate,
      );

  @override
  List<Object?> get props => [
        actionType,
        note,
        isTitleValid,
        message,
        event,
        hasUpdate,
      ];
}
