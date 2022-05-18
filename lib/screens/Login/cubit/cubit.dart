import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_mobile/helper/network/dioHelper.dart';
import 'package:university_project_mobile/models/student.dart';
import 'package:university_project_mobile/screens/Login/cubit/states.dart';
import 'package:university_project_mobile/screens/Login/login.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  //to get an object of bloc provider to deal with and call it easier
  // var blocProvider= BlocProvider.of(context);//to invite an object from bloc provider// context here will be unkown we must create a method that gives an object of class
  static LoginCubit get(context) => BlocProvider.of(context);
  //final dio = Dio();
  //StudentModel? studentModel;

  // void userLogin({ required String login,required String password})  {
  //   log("here");
  //   emit(LoginLoadingState());
  //   log('0');
  //   DioHelper.postData(url:'api/authStudent', data:{
  //   'login': login,
  //   'password': password
  //   }).then((value) {
  //     log('1');
  //     log('hello');
  //     log(value.data);
  //     emit(LoginSuccessState());
  //     return value.data;
  //
  //   }).catchError ((error) {
  //     emit(LoginErrorState(error.toString()));
  //     log(error.toString());
  //     return error.response!.data;
  //   });
  // }

   Future <void> userLogin({ required String login,required String password}) async{
     debugPrint("here");
    emit(LoginLoadingState());
     log( ' 000');
    try{
      Response response  = await DioHelper.postData(url:'api/authStudent',data: {
        'login': login,
        'password': password
      });
      // debugPrint(response.data.map((e){
      //  return e.toString() ;
      // }));

      print(  response.data['token']);

      emit(LoginSuccessState());
    }catch(e){
      debugPrint(e.toString());
    }
  }

  String teed() {
    emit(LoginLoadingState());
    return "hello fro eya ";
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
   isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
