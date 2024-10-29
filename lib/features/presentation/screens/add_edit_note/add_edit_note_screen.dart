import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/core/constants/app_strings.dart';
import 'package:noteapp/core/di/dependency_injection.dart' as di;
import 'package:noteapp/features/domain/enum/action_type.dart';
import 'package:noteapp/features/domain/model/action_param_model.dart';
import 'package:noteapp/features/presentation/components/app_scaffold.dart';
import 'package:noteapp/features/presentation/screens/add_edit_note/bloc/add_edit_note_bloc.dart';
import 'package:noteapp/features/presentation/screens/add_edit_note/bloc/add_edit_note_state.dart';

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
        title: const _AppTitle(),
        actions: const [
          _HeaderActions(),
        ],
      ),
      body: const SizedBox(),
    );
  }
}

class _AppTitle extends StatelessWidget {
  const _AppTitle();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditNoteBloc, AddEditNoteState>(
      buildWhen: (prev, current) => prev.actionType != current.actionType,
      builder: (context, state) {
        final action = state.actionType;
        String title = "";
        switch (action) {
          case ActionType.add:
            title = AppStrings.addNote;
            break;
          case ActionType.edit:
            title = AppStrings.editNote;
            break;
          case ActionType.view:
            title = AppStrings.note;
            break;
        }
        return Text(
          title,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        );
      },
    );
  }
}

class _HeaderActions extends StatelessWidget {
  const _HeaderActions();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddEditNoteBloc>();
    return BlocBuilder<AddEditNoteBloc, AddEditNoteState>(
      buildWhen: (prev, current) => prev.actionType != current.actionType,
      builder: (context, state) {
        final action = state.actionType;
        return Row(
          children: [
            if (action == ActionType.add)
              _IconView(
                icon: Icons.save,
                onTap: () {

                },
              ),
            if (action == ActionType.view)
              _IconView(
                margin: EdgeInsets.only(right: 10.w),
                icon: Icons.edit,
                onTap: () {
                  bloc.setAction(ActionType.edit);
                },
              ),
            if (action == ActionType.view)
              _IconView(
                icon: Icons.delete,
                onTap: () {

                },
              ),
            if (action == ActionType.edit)
              _IconView(
                icon: Icons.close,
                onTap: () {
                  bloc.setAction(ActionType.view);
                },
              ),
            SizedBox(width: 10.w),
          ],
        );
      }
    );
  }
}

class _IconView extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final EdgeInsets? margin;

  const _IconView({
    required this.icon,
    required this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Icon(
            icon,
            size: 30.h, // Customize the size
          ),
        ),
      ),
    );
  }
}
