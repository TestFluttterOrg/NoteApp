import 'dart:convert';
import 'package:noteapp/core/constants/app_constants.dart';
import 'package:noteapp/core/constants/app_strings.dart';
import 'package:noteapp/features/data/api/api_service.dart';
import 'package:noteapp/features/domain/entity/note_entity.dart';
import 'package:noteapp/features/domain/entity/note_list_entity.dart';
import 'package:noteapp/features/domain/model/result_model.dart';
import 'package:http/http.dart' as http;

class APIServiceImpl extends APIService {
  @override
  Future<ResultModel<NoteEntity>> addNote(NoteEntity note) async {
    try {
      var url = Uri.parse("${AppConstants.apiBaseUrl}/api/notes");
      var response = await http.post(url, body: note.toJson());
      if (response.statusCode == 201) {
        final rawData = response.body;

        //Convert raw data to map
        final jsonData = json.decode(rawData);

        //Convert json data to note entity
        final entity = NoteEntity.fromJson(jsonData);

        return ResultModel(
          isSuccess: true,
          data: entity,
          message: AppStrings.messageNoteAdded,
        );
      }
    } catch (_) {}
    return const ResultModel(
      isSuccess: false,
      message: AppStrings.messageFailedToAdd,
    );
  }

  @override
  Future<ResultModel> deleteNote(String noteId) async {
    try {
      var url = Uri.parse("${AppConstants.apiBaseUrl}/api/notes/$noteId");
      var response = await http.delete(url);
      if (response.statusCode == 200) {
        return const ResultModel(
          isSuccess: true,
          message: AppStrings.messageNoteDeleted,
        );
      }
    } catch (_) {}
    return const ResultModel(
      isSuccess: false,
      message: AppStrings.messageFailedToDelete,
    );
  }

  @override
  Future<ResultModel<List<NoteEntity>>> fetchNotes() async {
    try {
      var url = Uri.parse("${AppConstants.apiBaseUrl}/api/notes");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final rawData = response.body;

        // Decode JSON string to List<dynamic>
        final List<dynamic> jsonList = json.decode(rawData);

        // Map JSON list to List<NoteEntity>
        final List<NoteEntity> notes = jsonList.map((json) => NoteEntity.fromJson(json as Map<String, dynamic>)).toList();

        return ResultModel(
          isSuccess: true,
          data: notes,
        );
      }
    } catch (_) {}
    return const ResultModel(
      isSuccess: false,
      message: AppStrings.messageFailedToGetNotes,
    );
  }

  @override
  Future<ResultModel<NoteEntity>> updateNote(NoteEntity note) async {
    try {
      var url = Uri.parse("${AppConstants.apiBaseUrl}/api/notes/${note.id ?? ""}");
      var response = await http.put(url, body: note.toJson());
      if (response.statusCode == 200) {
        final rawData = response.body;

        //Convert raw data to map
        final jsonData = json.decode(rawData);

        //Convert map to note entity
        final entity = NoteEntity.fromJson(jsonData);

        return ResultModel(
          isSuccess: true,
          message: AppStrings.messageNoteEdited,
          data: entity,
        );
      }
    } catch (_) {}
    return const ResultModel(
      isSuccess: false,
      message: AppStrings.messageFailedToEdit,
    );
  }
}
