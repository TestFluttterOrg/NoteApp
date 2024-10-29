import 'package:noteapp/features/domain/enum/action_type.dart';
import 'package:noteapp/features/domain/model/note_model.dart';

class ActionParamModel {
  final ActionType actionType;
  final NoteModel? data;

  const ActionParamModel({
    required this.actionType,
    this.data,
  });
}
