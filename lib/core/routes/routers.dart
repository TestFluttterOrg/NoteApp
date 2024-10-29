import 'package:go_router/go_router.dart';
import 'package:noteapp/core/routes/app_routes.dart';
import 'package:noteapp/features/domain/model/action_param_model.dart';
import 'package:noteapp/features/presentation/screens/add_edit_note/add_edit_note_screen.dart';
import 'package:noteapp/features/presentation/screens/note_list/note_list_screen.dart';

class Routes {
  Routes._();

  static final routers = GoRouter(
    initialLocation: AppRoutes.noteList,
    routes: [
      //Note List
      GoRoute(
        path: AppRoutes.noteList,
        name: AppRoutes.noteList,
        builder: (_, __) {
          return const NoteListScreen();
        },
      ),
      //Add Edit Note
      GoRoute(
        path: AppRoutes.addEditNote,
        name: AppRoutes.addEditNote,
        builder: (_, state) {
          final action = state.extra as ActionParamModel;
          return AddEditNoteScreen(action: action);
        },
      ),
    ],
  );
}
