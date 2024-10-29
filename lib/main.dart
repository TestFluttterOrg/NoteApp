import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/core/constants/app_constants.dart';
import 'package:noteapp/core/constants/app_strings.dart';
import 'package:noteapp/core/routes/routers.dart';
import 'package:noteapp/core/di/dependency_injection.dart' as di;
import 'package:noteapp/features/presentation/screens/note_list/bloc/note_list_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Set to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: [
        //Global BLOCs
        BlocProvider(create: (_) => di.vf<NoteListBloc>()..initialize()),
      ],
      child: ScreenUtilInit(
        builder: (context, widget) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            theme: ThemeData(
              fontFamily: AppConstants.appFont,
            ),
            routerConfig: Routes.routers,
          );
        },
      ),
    );
  }
}
