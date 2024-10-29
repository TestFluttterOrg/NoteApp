import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/core/constants/app_strings.dart';
import 'package:noteapp/core/di/dependency_injection.dart' as di;
import 'package:noteapp/features/domain/enum/action_type.dart';
import 'package:noteapp/features/domain/model/action_param_model.dart';
import 'package:noteapp/features/presentation/components/app_input.dart';
import 'package:noteapp/features/presentation/components/app_scaffold.dart';
import 'package:noteapp/features/presentation/screens/add_edit_note/bloc/add_edit_note_bloc.dart';
import 'package:noteapp/features/presentation/screens/add_edit_note/bloc/add_edit_note_state.dart';

TextEditingController _titleController = TextEditingController();
TextEditingController _contentController = TextEditingController();

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
    final bloc = context.read<AddEditNoteBloc>();
    return AppScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const _AppTitle(),
        actions: const [
          _HeaderActions(),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 10.h,
          bottom: 20.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title Label
            const _FormLabelView(text: AppStrings.title),
            //Title TextField
            BlocBuilder<AddEditNoteBloc, AddEditNoteState>(
              buildWhen: (prev, current) => prev.isTitleValid != current.isTitleValid,
              builder: (context, state) {
                return AppInput(
                  controller: _titleController,
                  isValid: state.isTitleValid,
                  errorMessage: state.isTitleValid ? "" : AppStrings.messageTitleCannotBeEmpty,
                  onTextChanged: bloc.validateTitle,
                );
              },
            ),
            SizedBox(height: 10.h),
            //Content Label
            const _FormLabelView(text: AppStrings.content),
            //Content TextField
            Expanded(
              child: SizedBox(
                child: AppInput(
                  controller: _contentController,
                  maxLines: null,
                  minLines: null,
                  keyboardType: TextInputType.multiline,
                  expands: true,
                ),
              ),
            ),
          ],
        ),
      ),
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
            if (action == ActionType.add || action == ActionType.edit)
              _IconView(
                margin: EdgeInsets.only(right: 10.w),
                icon: Icons.save,
                onTap: () {
                  bloc.save(
                    title: _titleController.text,
                    content: _contentController.text,
                  );
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
                margin: EdgeInsets.only(right: 10.w),
                icon: Icons.delete,
                onTap: () {},
              ),
            if (action == ActionType.edit)
              _IconView(
                margin: EdgeInsets.only(right: 10.w),
                icon: Icons.close,
                onTap: () {
                  bloc.setAction(ActionType.view);
                },
              ),
          ],
        );
      },
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
      color: Colors.transparent,
      margin: margin,
      child: Material(
        color: Colors.transparent,
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

class _FormLabelView extends StatelessWidget {
  final String text;

  const _FormLabelView({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        color: Colors.black,
      ),
    );
  }
}
