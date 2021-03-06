import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:university_project_mobile/helper/network/dioHelper.dart';
import 'package:university_project_mobile/layout/cubit/cubit.dart';
import 'package:university_project_mobile/screens/Login/Login.dart';
import 'package:university_project_mobile/screens/Login/Login.dart';
import 'package:university_project_mobile/screens/VerifEmail/emailVerif.dart';
import 'package:university_project_mobile/screens/VerifEmail/sendEmail.dart';
import 'package:university_project_mobile/screens/HomeScreen/HomeScreen.dart';
import 'package:university_project_mobile/helper/bloc_ovserver.dart';

import 'helper/cache_helper.dart';
import 'layout/school_Layout.dart';

void main() async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await FlutterDownloader.initialize(
          debug: true // optional: set false to disable printing logs to console
      );
      await CacheHelper.init();
      Widget widget;
    var  token = CacheHelper.getData(key: 'token');
      if(token != null)
      {
        //   CacheHelper.removeData(
        //    key: 'uId',
        // );
        widget = school_Layout();
      } else
      {
        widget = LoginScreen();
      }

      runApp( MyApp(
        startWidget: widget,
      ));

    },
      blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {
 // const MyApp({Key? key}) : super(key: key);
  final Widget startWidget;

  MyApp({
    //this.isDark,
    required this.startWidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SchoolCubit>(create: (context) => SchoolCubit()),
        ],
      child: MaterialApp(

              debugShowCheckedModeBanner: false,
              title: 'university',
              theme: ThemeData(
              ),
              home: LoginScreen(),
            )

    );
  }
}
