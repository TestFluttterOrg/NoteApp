import 'dart:convert';

import 'package:noteapp/core/constants/app_strings.dart';
import 'package:noteapp/features/data/api/api_service.dart';
import 'package:noteapp/features/data/datasource/constants/pref_constants.dart';
import 'package:noteapp/features/data/datasource/shared_pref_datasource.dart';
import 'package:noteapp/features/domain/entity/note_entity.dart';
import 'package:noteapp/features/domain/entity/note_list_entity.dart';
import 'package:noteapp/features/domain/model/result_model.dart';

class APIServiceImpl extends APIService {
  final SharedPrefDataSource sharedPrefDataSource;

  APIServiceImpl({
    required this.sharedPrefDataSource,
  });

  final List<NoteEntity> _noteList = [];

  @override
  Future<ResultModel<NoteEntity>> addNote(NoteEntity note) async {
    try {
      //generate id base on the previous counter
      final id = int.parse(await sharedPrefDataSource.getData(PrefConstants.noteIdCtrKey) ?? "0") + 1;

      final noteData = note.copyWith(id: id);

      //Add to note list
      _noteList.add(noteData);

      final noteList = NoteListEntity(data: _noteList).toJson();

      //Save the new list to local
      final jsonData = jsonEncode(noteList);
      await sharedPrefDataSource.setData(PrefConstants.notesKey, jsonData);

      return ResultModel(
        isSuccess: true,
        data: noteData,
      );

    } catch (_) {
      return const ResultModel(
        isSuccess: false,
        message: AppStrings.messageFailedToSave,
      );
    }
  }

  @override
  Future<ResultModel> deleteNote(String noteId) async {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<ResultModel<List<NoteEntity>>> fetchNotes() async {
    try {
      if (_noteList.isEmpty) {

        //Delay in 2 seconds to simulate API call
        await Future.delayed(const Duration(seconds: 2));

        //Get raw string from shared pref
        final notesRaw = await sharedPrefDataSource.getData(PrefConstants.notesKey);
        if (notesRaw == null) {
          return const ResultModel(
            isSuccess: false,
            isNoData: true,
            message: AppStrings.messageNoDataFound,
          );
        }

        //Convert raw string to map
        final jsonData = json.decode(notesRaw);

        //Convert map to note list entity
        final noteList = NoteListEntity.fromJson(jsonData);

        _noteList.clear();
        _noteList.addAll(noteList.data);

      }

      return ResultModel(
        isSuccess: true,
        data: _noteList,
      );
    } catch (_) {
      return const ResultModel(
        isSuccess: false,
        message: AppStrings.messageFailedToGetNotes,
      );
    }
  }

  @override
  Future<ResultModel> updateNote(NoteEntity note) async {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
