import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/core/constants/app_strings.dart';
import 'package:noteapp/core/di/dependency_injection.dart' as di;
import 'package:noteapp/features/domain/model/action_param_model.dart';
import 'package:noteapp/features/presentation/components/app_scaffold.dart';
import 'package:noteapp/features/presentation/screens/add_edit_note/bloc/add_edit_note_bloc.dart';

class AddEditNoteScreen extends StatelessWidget {
  final ActionParamModel action;

  const AddEditNoteScreen({
    required this.action,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.vf<AddEditNoteBloc>()..initialize(action)),
      ],
      child: const _AddEditNoteForm(),
    );
  }
}

class _AddEditNoteForm extends StatelessWidget {
  const _AddEditNoteForm();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppStrings.addNote,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: const SizedBox(),
    );
  }
}
