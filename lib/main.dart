import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:university_project_mobile/helper/network/dioHelper.dart';
import 'package:university_project_mobile/screens/Login/cubit/cubit.dart';
import 'package:university_project_mobile/screens/Login/cubit/states.dart';
import 'package:university_project_mobile/screens/Login/login.dart';
import 'package:university_project_mobile/screens/Login/login.dart';
import 'package:university_project_mobile/screens/VerifEmail/emailVerif.dart';
import 'package:university_project_mobile/screens/VerifEmail/sendEmail.dart';
import 'package:university_project_mobile/screens/HomeScreen/homeScreen.dart';
import 'package:university_project_mobile/screens/profilePages/profile_page.dart';
import 'package:university_project_mobile/shared/bloc_ovserver.dart';

import 'helper/network/mongodbConnection.dart';

void main() async {
 //mongodbConnect
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      //await MongoDatabase.connect();
      blocObserver: MyBlocObserver();
    },

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
      ],
      child: MaterialApp(

              debugShowCheckedModeBanner: false,
              title: 'university',
              theme: ThemeData(
              ),
              home: const LoginScreen(),
            )

    );
  }
}
