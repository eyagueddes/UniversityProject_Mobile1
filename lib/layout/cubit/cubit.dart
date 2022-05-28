
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:university_project_mobile/layout/cubit/states.dart';
import 'package:university_project_mobile/models/Messages.dart';
import 'package:university_project_mobile/models/demands.dart';
import 'package:university_project_mobile/models/student.dart';
import 'package:university_project_mobile/screens/TimeSchedule/time_schedule.dart';
import 'package:university_project_mobile/screens/actualities/actualities.dart';
import 'package:university_project_mobile/screens/messages/allMessages.dart';
import '../../helper/cache_helper.dart';
import '../../helper/network/dioHelper.dart';
import '../../models/actualities.dart';
import '../../models/marks.dart';
import '../../models/teacher.dart';
import '../../screens/HomeScreen/homeScreen.dart';
import '../../screens/Notices/notices.dart';
import '../../screens/Profile/profile.dart';
import '../../../models/student.dart';
import '../../screens/ResultDeliberation/resultDeliberation.dart';
import '../../screens/StudyPlan/study_plan.dart';
import '../../screens/demands/addDemand.dart';
import '../../screens/examCalendar/exam_calendar.dart';
import '../../screens/messages/add_message.dart';
import '../../screens/teachers/teacher_screen.dart';
import '../../screens/TimeSchedule/time_schedule.dart';
import '../../screens/updateProfile/update_profile.dart';
import 'package:image_picker/image_picker.dart';

class SchoolCubit extends Cubit<SchoolStates> {
  SchoolCubit() : super(SchoolInitialState());

  static SchoolCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const home_screen(),
    profile_screen(),
    update_profile(),

  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    print(currentIndex);
    emit(SchoolChangeIndexBottomNavBar());
  }

  List<Widget> Homescreens = [
    const add_demand(),
    const get_allMessages(),
    const result_Deliberation(),
    exam_calendar(),
    const study_plan(),
    const time_schedule(),
    const notices(),
    const teacher_screen(),
    const actualities(),
  ];

  void changeCardIndex(int index) {
    currentIndex = index;
    print(currentIndex);
    emit(ChangeRouteLoadingSuccessState());
  }

  Future <void> userLogin(
      { required String login, required String password}) async {
    emit(LoginLoadingState());
    try {
      Response response = await DioHelper.postData(
        url: 'api/authStudent', data: {
        'login': login,
        'password': password
      },
      );
      CacheHelper.saveData(key: 'token', value: response.data['token']);
      print(response.data['token']);
      emit(LoginSuccessState());
    } catch (e) {
      print(e.toString());
      emit(LoginErrorState(e.toString()));
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  StudentData? studentData;

  var profileImage;

  Future<void> getUserData() async {
    emit(SchoolLoadingUserDataState());
    print('recherche en cours');
    final token = CacheHelper.getData(key: "token");
    print('token,$token');
    DioHelper.getData(
        url: 'api/authStudent',
        token: CacheHelper.getData(key: 'token')).then((value) {
      print('the user is ,$value');
      studentData = StudentData.fromJson(value.data);
      print("the client is");
      print(studentData?.name);
      profileImage = studentData?.avatar;
      print('img,$profileImage');
      emit(SchoolUserLoadingDataSuccess(studentData));
    }).catchError((error) async {
      print(error.toString());
      emit(SchoolUserLoadingDataError(error.toString()));
    });
  }

  List<dynamic> allActualities = [];
  ActualityModel? actualityModel;

  Future<void> getActualities() async {
    emit(LoadingActualitiesDataState());
    DioHelper.getData(
      url: 'api/news/actuality/all',
    ).then((value) {
      print('Actualities ,$value');
      allActualities = value.data;
      allActualities.map((e) =>
      actualityModel = ActualityModel.fromJson(e));
      print(allActualities.length);
      print(allActualities[0]['_id']);
      emit(ActualitiesLoadingDataSuccess());
    }).catchError((error) async {
      print(error.toString());
      emit(ActualitiesLoadingDataError(error.toString()));
    });
  }

  final Demands = [
    'Attestation de présence',
    "Carte d'étudiant",
    "Attestation D'inscription",
  ];

  var name;
  var LastName;
  var studentId;

  Future <void> addDemand(
      { required String subject, required String phone, String? langue}) async {
    print("here");
    emit(DemandAddingLoadingState());
    DioHelper.getData(
        url: 'api/authStudent',
        token: CacheHelper.getData(key: 'token')).then((value) async {
      print('the user is ,$value');
      studentData = StudentData.fromJson(value.data);
      name = studentData?.name;
      LastName = studentData?.LastName;
      studentId = studentData?.id;
      print('name ,$name');
      print('LastName ,$LastName');
      Response response = await DioHelper.postData(
        url: 'api/demand/add', data: {
        'subject': subject,
        'phone': phone,
        'langue': langue,
        'studentName': name + ' ' + LastName,
        'StudentId': studentId,
      },
      );
      print(response.data);
      emit(DemandAddingSuccessState());
    }).catchError((error) async {
      print(error.toString());
      emit(DemandAddingErrorState(error.toString()));
    });
  }

  var exam;

  Future<void> getUserExamCalendar() async {
    emit(LoadingExamCalendarDataState());
    print('recherche en cours');
    final token = CacheHelper.getData(key: "token");
    print('token,$token');
    DioHelper.getData(
        url: 'api/studentDocuments/examsCalendar',
        token: CacheHelper.getData(key: 'token')).then((value) {
      print('ExamCalendar ,$value');
      // studentModel =  StudentModel.fromJson(value.data);
      emit(ExamCalendarLoadingDataSuccess());
      exam = value;
      print(exam);
    }).catchError((error) async {
      print(error.toString());
      emit(ExamCalendarLoadingDataError(error.toString()));
    });
  }


  void downloadExamCalendar() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();
      final id = await FlutterDownloader.enqueue(
        url: exam.toString(),
        savedDir: externalDir!.path,
        fileName: "Calendrier Examens",
        showNotification: true,
        openFileFromNotification: true,

      );
    } else {
      print('Permission Denied');
    }
  }

  var document;
  DeliberationModel? deliberationModel;

  Future<void> getResultDeliberation() async {
    emit(LoadingResultDeliberationDataState());
    print('recherche en cours');
    final token = CacheHelper.getData(key: "token");
    print('token,$token');
    DioHelper.getData(
        url: 'api/studentDocuments/result',
        token: CacheHelper.getData(key: 'token')).then((value) {
      print('ResultDeliberation ,${value}');
      deliberationModel = DeliberationModel.fromJson(value.data);
      print("result is");
      print(deliberationModel?.classe);
      document = deliberationModel?.document;
      // studentModel =  StudentModel.fromJson(value.data);
      emit(ResultDeliberationLoadingDataSuccess());
    }).catchError((error) async {
      print(error.toString());
      emit(ResultDeliberationLoadingDataError(error.toString()));
    });
  }

  void downloadDeliberation() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();
      final id = await FlutterDownloader.enqueue(
        url: document,
        savedDir: externalDir!.path,
        fileName: "Fichier de délibération",
        showNotification: true,
        openFileFromNotification: true,

      );
    } else {
      print('Permission Denied');
    }
  }

  Future <void> addMessage(
      { required String subject, required String text, String? phone}) async {
    print("here");
    emit(MessagesAddingLoadingState());
    DioHelper.getData(
        url: 'api/authStudent',
        token: CacheHelper.getData(key: 'token')).then((value) async {
      print('the user is ,$value');
      studentData = StudentData.fromJson(value.data);
      name = studentData?.name;
      LastName = studentData?.LastName;
      studentId = studentData?.id;
      print('name ,$name');
      print('name ,$name');
      print('LastName ,$LastName');
      Response response = await DioHelper.postData(
        url: 'api/message/add', data: {
        'subject': subject,
        'text': text,
        'studentName': name + ' ' + LastName,
        'StudentId': studentId,
        'phone': phone
      },
      );
      print(response.data);
      emit(MessagesAddingSuccessState());
    }).catchError((error) async {
      print(error.toString());
      emit(MessagesAddingErrorState(error.toString()));
    });
  }

  var plan;

  Future<void> getUserStudyPlan() async {
    emit(LoadingStudyPlanDataState());
    print('recherche en cours');
    final token = CacheHelper.getData(key: "token");
    print('token,$token');
    DioHelper.getData(
        url: 'api/studentDocuments/studyPlan',
        token: CacheHelper.getData(key: 'token')).then((value) {
      print('StudyPlan ,$value');
      plan = value;
      print('plan,$plan');
      // studentModel =  StudentModel.fromJson(value.data);
      emit(StudyPlanLoadingDataSuccess());
    }).catchError((error) async {
      print(error.toString());
      emit(StudyPlanLoadingDataError(error.toString()));
    });
  }

  void downloadPlan() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();
      final id = await FlutterDownloader.enqueue(
        url: plan.toString(),
        savedDir: externalDir!.path,
        fileName: "Plan d'étude",
        showNotification: true,
        openFileFromNotification: true,

      );
    } else {
      print('Permission Denied');
    }
  }

  List<dynamic> allteachers = [];
  TeacherModel? teacherModel;

  Future<void> getTeachers() async {
    emit(TeacherLoadingDataState());
    DioHelper.getData(
      url: 'api/teacher/all',
    ).then((value) {
      print('teachers ,$value');
      allteachers = value.data;
      allteachers.map((e) =>
      teacherModel = TeacherModel.fromJson(e));
      print(allteachers.length);
      print(allteachers[0]['_id']);
      emit(TeacherLoadingDataSuccess(teacherModel));
    }).catchError((error) async {
      print(error.toString());
      emit(TeacherLoadingDataError(error.toString()));
    });
  }

  var schedule;

  Future<void> getUserTimeSchedule() async {
    emit(LoadingTimeScheduleDataState());
    print('recherche en cours');
    final token = CacheHelper.getData(key: "token");
    print('token,$token');
    DioHelper.getData(
        url: 'api/studentDocuments/timeSchedule',
        token: CacheHelper.getData(key: 'token')).then((value) {
      print('timeschedule ,$value');
      schedule = value;
      // studentModel =  StudentModel.fromJson(value.data);
      emit(TimeScheduleLoadingDataSuccess());
    }).catchError((error) async {
      print(error.toString());
      emit(TimeScheduleLoadingDataError(error.toString()));
    });
  }

  void downloadTimeSchedule() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();
      final id = await FlutterDownloader.enqueue(
        url: schedule.toString(),
        savedDir: externalDir!.path,
        fileName: "Emploi de temps",
        showNotification: true,
        openFileFromNotification: true,

      );
    } else {
      print('Permission Denied');
    }
  }


  DemandModel? demandModel;

  Future<void> getDemands() async {
    emit(DemandsLoadingDataState());
    print('recherche en cours');
    final token = CacheHelper.getData(key: "token");
    print('token,$token');
    DioHelper.getData(
        url: 'api/studentDocuments/demands',
        token: CacheHelper.getData(key: 'token')).then((value) {
      print('demands ,${value}');
      demandModel = DemandModel.fromJson(value.data);
        print(demandModel);
      emit(DemandsLoadingDataSuccess(demandModel));
    }).catchError((error) async {
      print(error.toString());
      emit(DemandsLoadingDataError(error.toString()));
    });
  }
  MessageModel? messageModel;
  List<dynamic> allMessages = [];
  Future<void> getMessages() async {
    print('recherche en cours');
    emit(MessagesLoadingDataState());
    final token = CacheHelper.getData(key: "token");
    print('token,$token');
    DioHelper.getData(
        url: 'api/studentDocuments/messages',
        token: CacheHelper.getData(key: 'token')).then((value) {
      print('messages ,${value}');
      allMessages=value.data;
      allMessages.map((e) =>
      messageModel = MessageModel.fromJson(e));
      print(allMessages.length);
      print(allMessages[0]['_id']);
      print(allMessages[0]['subject']);
      emit(MessagesLoadingDataSuccess(messageModel));
    }).catchError((error) async {
      print(error.toString());
      emit(MessagesLoadingDataError(error.toString()));
    });
  }






  var newProfileImage;
  Future<void> getProfileImage (ImageSource source) async{
    ImagePicker _picker = ImagePicker();
    print('here');
    try{
      newProfileImage = await _picker.pickImage(source: source) ;
      if (newProfileImage != null) {
       // uploadImage (newProfileImage);
        print(newProfileImage!.path);
        emit(SchoolProfileImagePickedSuccessState());
      }else {
        print('No image selected');
        emit(SchoolProfileImagePickedErrorState(error: 'No image Selected'));
      }
    }catch (error){
      emit(SchoolProfileImagePickedErrorState(error: error.toString()));
    }
  }

  Future<void> uploadImage (file) async {
    print('goo');
    emit(SchoolUploadProfileImageLoadingState());

    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({


        "avatar":
        await MultipartFile.fromFile(file.path, filename:fileName),
        //"client_id":CacheHelper.getData(key: 'Id')
      });
      print('sss');
      print(formData.fields);
     print(formData.fields);
      var response = await DioHelper.putImage(url:'api/authStudent/updateProfileImageStudent',data:formData , token :  CacheHelper.getData(key: 'token'));
      print(response);
      getUserData();
      await CachedNetworkImage.evictFromCache('${studentData!.avatar}');
      emit(SchoolUploadProfileImageSuccessState());
    }catch(error){
      print(error.toString());
      emit(SchoolUploadProfileImageErrorState(error: error.toString()));
    }
  }

}


