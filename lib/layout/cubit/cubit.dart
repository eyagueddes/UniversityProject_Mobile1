import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_mobile/layout/cubit/states.dart';
import 'package:university_project_mobile/models/student.dart';
import '../../helper/cache_helper.dart';
import '../../helper/network/dioHelper.dart';
import 'dart:developer';
import '../../screens/HomeScreen/homeScreen.dart';
import '../../screens/Profile/profile.dart';
import '../../screens/updateProfile/update_profile.dart';

class SchoolCubit extends Cubit<SchoolStates> {
  SchoolCubit() : super(SchoolInitialState());
  static SchoolCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    home_screen(),
    profile_screen(),
    update_profile(),
  ];
  void changeBottomNav(int index) {
    currentIndex = index;
    print(currentIndex);
    emit(SchoolChangeIndexBottomNavBar());
  }

  StudentModel? studentModel;
  Future<void> getUserData() async {
    emit(SchoolLoadingUserDataState());
    DioHelper.postData(
        url: '',
        data: {"token": CacheHelper.getData(key: 'token')}).then((value) {
      studentModel = StudentModel.fromJson(value.data);
      print("the user is");
      print(studentModel?.name);
      emit(SchoolUserLoadingDataSuccess(studentModel));
    }).catchError((error) async {
      print(error.toString());

      emit(SchoolUserLoadingDataError(error.toString()));
    });
  }
}
