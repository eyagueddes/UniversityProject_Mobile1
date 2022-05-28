import 'package:university_project_mobile/models/Messages.dart';
import 'package:university_project_mobile/models/demands.dart';
import 'package:university_project_mobile/models/student.dart';

import '../../models/student.dart';
import '../../models/teacher.dart';

abstract class SchoolStates {}
class SchoolInitialState extends SchoolStates {}
class SchoolChangeIndexBottomNavBar extends SchoolStates {}
class SchoolLoadingUserDataState extends SchoolStates {}
class SchoolUserLoadingDataSuccess extends SchoolStates {
  final StudentData? studentModel ;

  SchoolUserLoadingDataSuccess(this.studentModel);
}
class SchoolUserLoadingDataError extends SchoolStates {
  late String error ;
  SchoolUserLoadingDataError(this.error);
}
class actualitiesInitialState extends SchoolStates {}
class LoadingActualitiesDataState extends SchoolStates {}
class ActualitiesLoadingDataSuccess extends SchoolStates {
  // final StudentModel? studentModel ;

  ActualitiesLoadingDataSuccess();
}
class ActualitiesLoadingDataError extends SchoolStates {
  late String error ;
  ActualitiesLoadingDataError(this.error);
}

class DemandInitialState extends SchoolStates {}
class DemandAddingLoadingState extends SchoolStates {}

class DemandAddingSuccessState extends SchoolStates {

}
class  DemandAddingErrorState extends SchoolStates {
  late String error ;
  DemandAddingErrorState(this.error);
}
class examCalendarInitialState extends SchoolStates {}
class LoadingExamCalendarDataState extends SchoolStates {}
class ExamCalendarLoadingDataSuccess extends SchoolStates {
  // final StudentModel? studentModel ;

  ExamCalendarLoadingDataSuccess();
}
class ExamCalendarLoadingDataError extends SchoolStates {
  late String error ;
  ExamCalendarLoadingDataError(this.error);
}
class HomeInitialState extends SchoolStates {}
class HomeChangeIndexCardState extends SchoolStates {}
class ChangeRouteLoadingState extends SchoolStates {}
class ChangeRouteLoadingSuccessState extends SchoolStates {

}
class  ChangeRouteLoadingDataError extends SchoolStates {
  late String error ;
  ChangeRouteLoadingDataError(this.error);
}

class LoginInitialState extends SchoolStates {}

class LoginChangeState extends SchoolStates {}

class LoginLoadingState extends SchoolStates {}

class LoginSuccessState extends SchoolStates
{


  LoginSuccessState();
}

class LoginErrorState extends SchoolStates
{
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends SchoolStates {}

class MessagesInitialState extends SchoolStates {}
class MessagesAddingLoadingState extends SchoolStates {}

class MessagesAddingSuccessState extends SchoolStates {

}
class  MessagesAddingErrorState extends SchoolStates {
  late String error ;
  MessagesAddingErrorState(this.error);
}
class ResultDeliberationInitialState extends SchoolStates {}
class LoadingResultDeliberationDataState extends SchoolStates {}
class  ResultDeliberationLoadingDataSuccess extends SchoolStates {
  // final StudentModel? studentModel ;

  ResultDeliberationLoadingDataSuccess();
}
class ResultDeliberationLoadingDataError extends  SchoolStates {
  late String error ;
  ResultDeliberationLoadingDataError(this.error);
}
class timeScheduleInitialState extends SchoolStates {}
class LoadingTimeScheduleDataState extends SchoolStates {}
class TimeScheduleLoadingDataSuccess extends SchoolStates {
  // final StudentModel? studentModel ;

  TimeScheduleLoadingDataSuccess();
}
class TimeScheduleLoadingDataError extends SchoolStates {
  late String error ;
  TimeScheduleLoadingDataError(this.error);
}
class StudyPlanInitialState extends SchoolStates {}
class LoadingStudyPlanDataState extends SchoolStates {}
class StudyPlanLoadingDataSuccess extends SchoolStates {
  // final StudentModel? studentModel ;

  StudyPlanLoadingDataSuccess();
}
class StudyPlanLoadingDataError extends SchoolStates {
  late String error ;
  StudyPlanLoadingDataError(this.error);
}
class TeacherInitialState extends SchoolStates {}
class TeacherLoadingDataState extends SchoolStates {}
class TeacherLoadingDataSuccess extends SchoolStates {
  final TeacherModel? teacherModel ;

  TeacherLoadingDataSuccess(this.teacherModel);
}
class TeacherLoadingDataError extends SchoolStates {
  late String error ;
  TeacherLoadingDataError(this.error);
}
class DemandsInitialState extends SchoolStates {}
class DemandsLoadingDataState extends SchoolStates {}
class DemandsLoadingDataSuccess extends SchoolStates {
  final DemandModel? demandModel ;

  DemandsLoadingDataSuccess(this.demandModel);
}
class DemandsLoadingDataError extends SchoolStates {
  late String error ;
  DemandsLoadingDataError(this.error);
}
class getMessagesInitialState extends SchoolStates {}
class MessagesLoadingDataState extends SchoolStates {}
class MessagesLoadingDataSuccess extends SchoolStates {
  final MessageModel? messageModel ;

  MessagesLoadingDataSuccess(this.messageModel);
}
class MessagesLoadingDataError extends SchoolStates {
  late String error ;
  MessagesLoadingDataError(this.error);
}
//update profile
class SchoolProfileImagePickedSuccessState extends SchoolStates {}

class SchoolProfileImagePickedErrorState extends SchoolStates {
  final String error ;
  SchoolProfileImagePickedErrorState({ required this.error});
}
class SchoolProfileImagePickedLoadingState extends SchoolStates {}
class SchoolUploadProfileImageSuccessState extends SchoolStates {}

class SchoolUploadProfileImageErrorState extends SchoolStates {
  final String error ;
  SchoolUploadProfileImageErrorState({ required this.error});
}

class SchoolUploadProfileImageLoadingState extends SchoolStates {}
class SchoolUserUpdateLoadingState extends SchoolStates {}

class SchoolUserUpdateErrorState extends SchoolStates {}
class SchoolUserUpdateSuccessState extends SchoolStates {}