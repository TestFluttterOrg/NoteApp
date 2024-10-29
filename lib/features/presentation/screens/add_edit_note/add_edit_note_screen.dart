import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/core/di/dependency_injection.dart' as di;
import 'package:noteapp/features/presentation/screens/add_edit_note/bloc/add_edit_note_bloc.dart';

class AddEditNoteScreen extends StatelessWidget {
  const AddEditNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.vf<AddEditNoteBloc>()),
      ],
      child: const _AddEditNoteForm(),
    );
  }
}

class _AddEditNoteForm extends StatelessWidget {
  const _AddEditNoteForm();

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
