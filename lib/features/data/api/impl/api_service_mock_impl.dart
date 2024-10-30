import 'dart:convert';

import 'package:noteapp/core/constants/app_strings.dart';
import 'package:noteapp/features/data/api/api_service.dart';
import 'package:noteapp/features/data/datasource/constants/pref_constants.dart';
import 'package:noteapp/features/data/datasource/shared_pref_datasource.dart';
import 'package:noteapp/features/domain/entity/note_entity.dart';
import 'package:noteapp/features/domain/model/result_model.dart';

class APIServiceMockImpl extends APIService {
  final SharedPrefDataSource sharedPrefDataSource;

  APIServiceMockImpl({
    required this.sharedPrefDataSource,
  });

  final List<NoteEntity> _noteList = [];

  Future<void> _saveTheUpdatedListToLocal() async {
    // Convert each NoteEntity to a JSON map
    List<Map<String, dynamic>> jsonList = _noteList.map((note) => note.toJsonWithIdAndCreated()).toList();

    // Convert the list of maps to a JSON string
    String jsonString = jsonEncode(jsonList);

    // Save to local
    await sharedPrefDataSource.setData(PrefConstants.notesKey, jsonString);
  }

  @override
  Future<ResultModel<NoteEntity>> addNote(NoteEntity note) async {
    try {
      //Add a delay to simulate API call
      await Future.delayed(const Duration(milliseconds: 1500));

      //Generate id
      final id = int.parse(await sharedPrefDataSource.getData(PrefConstants.noteIdCtrKey) ?? "0") + 1;

      //Create the entity
      final noteEntity = note.copyWith(id: id.toString(), createdAt: DateTime.now());

      //Add to the note list
      _noteList.add(noteEntity);

      await _saveTheUpdatedListToLocal();

      //Update the ID counter
      await sharedPrefDataSource.setData(PrefConstants.noteIdCtrKey, id.toString());

      return ResultModel(
        isSuccess: true,
        data: noteEntity,
        message: AppStrings.messageNoteAdded,
      );
    } catch (_) {}
    return const ResultModel(
      isSuccess: false,
      message: AppStrings.messageFailedToAdd,
    );
  }

  @override
  Future<ResultModel> deleteNote(String noteId) async {
    try {
      //Add a delay to simulate API call
      await Future.delayed(const Duration(milliseconds: 1500));

      _noteList.removeWhere((e) => e.id == noteId);

      await _saveTheUpdatedListToLocal();

      return const ResultModel(
        isSuccess: true,
        message: AppStrings.messageNoteDeleted,
      );
    } catch (_) {}

    return const ResultModel(
      isSuccess: false,
      message: AppStrings.messageFailedToDelete,
    );
  }

  @override
  Future<ResultModel<List<NoteEntity>>> fetchNotes() async {
    try {
      //Add a delay to simulate API call
      await Future.delayed(const Duration(milliseconds: 1500));

      if (_noteList.isEmpty) {
        final rawData = await sharedPrefDataSource.getData(PrefConstants.notesKey) ?? "[]";

        // Decode JSON string to List<dynamic>
        final List<dynamic> jsonList = json.decode(rawData);

        // Map JSON list to List<NoteEntity>
        final List<NoteEntity> notes = jsonList.map((json) => NoteEntity.fromJson(json as Map<String, dynamic>)).toList();

        // Store to note list
        _noteList.clear();
        _noteList.addAll(notes);
      }

      return ResultModel(
        isSuccess: true,
        data: _noteList,
      );
    } catch (_) {}
    return const ResultModel(
      isSuccess: false,
      message: AppStrings.messageFailedToGetNotes,
    );
  }

  @override
  Future<ResultModel<NoteEntity>> updateNote(NoteEntity note) async {
    try {
      //Add a delay to simulate API call
      await Future.delayed(const Duration(milliseconds: 1500));

      //Find item index
      final index = _noteList.indexWhere((e) => e.id == note.id);

      //Update the item
      _noteList[index] = note;

      //Save the updated list to local
      await _saveTheUpdatedListToLocal();

      return ResultModel(
        isSuccess: true,
        message: AppStrings.messageNoteEdited,
        data: note,
      );

    } catch (_) {

    }
    return const ResultModel(
      isSuccess: false,
      message: AppStrings.messageFailedToEdit,
    );
  }
}
