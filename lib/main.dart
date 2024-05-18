
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:maids_test/core/const/const.dart';
import 'package:maids_test/features/auth/presentation/pages/login.dart';
import 'package:maids_test/features/todos/presentation/pages/todos_page.dart';
import 'package:maids_test/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  await iniGetIt();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await ScreenUtil.ensureScreenSize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Builder(builder: (BuildContext context) {
        ScreenUtil.init(
          context,
          fontSizeResolver: (fontSize, instance) {
            if (instance.screenWidth < 600) {
              // For mobile screens, reduce font size
              return fontSize * 2.4;
            } else if (instance.screenWidth > 1024) {
              // For iPad screens, keep the original font size
              return fontSize * 3.3;
            } else {
              // For laptop screens, increase font size
              return fontSize * 2.5;
            }
          },
        );
        return  sl<SharedPreferences>().getString(User.id)==null?  const LoginPage():const TodoListPage();
      }),
    );
  }

//
}
