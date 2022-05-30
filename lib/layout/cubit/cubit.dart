
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
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
import 'package:university_project_mobile/screens/TimeSchedule/Time_schedule.dart';
import 'package:university_project_mobile/screens/actualities/Actualities.dart';
import 'package:university_project_mobile/screens/demands/All_demands.dart';
import 'package:university_project_mobile/screens/messages/All_Messages.dart';
import '../../helper/cache_helper.dart';
import '../../helper/network/dioHelper.dart';
import '../../models/actualities.dart';
import '../../models/marks.dart';
import '../../models/notices.dart';
import '../../models/teacher.dart';
import '../../screens/HomeScreen/HomeScreen.dart';
import '../../screens/Notices/Notices.dart';
import '../../screens/Profile/Profile.dart';
import '../../../models/student.dart';
import '../../screens/ResultDeliberation/Result_Deliberation.dart';
import '../../screens/StudyPlan/Study_plan.dart';
import '../../screens/demands/Add_Demand.dart';
import '../../screens/examCalendar/Exam_calendar.dart';
import '../../screens/messages/Add_message.dart';
import '../../screens/teachers/Teacher_screen.dart';
import '../../screens/TimeSchedule/Time_schedule.dart';
import '../../screens/updateProfile/Update_pro.dart';
import '../../screens/updateProfile/Update_profile.dart';
import 'package:image_picker/image_picker.dart';

class SchoolCubit extends Cubit<SchoolStates> {
  SchoolCubit() : super(SchoolInitialState());

  static SchoolCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const home_screen(),
    profile_screen(),
    UpdatePro(),

  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    print(currentIndex);
    emit(SchoolChangeIndexBottomNavBar());
  }

  List<Widget> Homescreens = [
    const get_allDemands(),
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


  final Demands = [
    'Attestation de présence',
    "Carte d'étudiant",
    "Attestation D'inscription",
  ];

  var name;
  var LastName;
  var studentId;

  Future <void> addDemand(
      { required String subject, required String phone, String? langue,String? raison}) async {
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
        'raison':raison,
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
  List<ActualityModel> allActualities = [];
  ActualityModel? actualityModel;

  Future<void> getActualities() async {
    emit(LoadingActualitiesDataState());
    DioHelper.getData(
      url: 'api/news/actuality/all',
    ).then((value) {
      print('Actualities ,$value');
      List actualities=value.data;
      print(actualities);
      //  allActualities = value.data;
      allActualities = actualities.map((e) {
        return ActualityModel.fromJson(e);
      }).toList();
      print(allActualities);
      emit(ActualitiesLoadingDataSuccess());

    }).catchError((error) async {
      print(error.toString());
      emit(ActualitiesLoadingDataError(error.toString()));
    });
  }
  List<TeacherModel> allTeachers = [];
  TeacherModel? teacherModel;
  List teachers=[];
  Future<void> getTeachers() async {
    emit(TeacherLoadingDataState());
    DioHelper.getData(
      url: 'api/teacher/all',
    ).then((value) {
      print('teachers ,$value');
      teachers = value.data;
      print(teachers);
      allTeachers = teachers.map((e) {
        return TeacherModel.fromJson(e);
      }).toList();
      print('all,$allTeachers');
      emit(TeacherLoadingDataSuccess());
    }).catchError((error) async {
      print(error.toString());
      emit(TeacherLoadingDataError(error.toString()));
    });
  }

  MessageModel? messageModel;
  List<MessageModel>  allMessages = [];
  Future<void> getMessages() async {
    print('recherche en cours');
    emit(MessagesLoadingDataState());
    final token = CacheHelper.getData(key: "token");
    print('token,$token');
    DioHelper.getData(
        url: 'api/studentDocuments/messages',
        token: CacheHelper.getData(key: 'token')).then((value) {
      print('messages ,${value}');
      List messages=value.data;
      print('msg ,$messages');
      allMessages=messages.map((e) =>
      messageModel = MessageModel.fromJson(e)).toList();
      emit(MessagesLoadingDataSuccess(messageModel));
    }).catchError((error) async {
      print(error.toString());
      emit(MessagesLoadingDataError(error.toString()));
    });
  }

  DemandModel? demandModel;
  List<DemandModel> allDemands=[];
  Future<void> getDemands() async {
    emit(DemandsLoadingDataState());
    print('recherche en cours');
    final token = CacheHelper.getData(key: "token");
    print('token,$token');
    DioHelper.getData(
        url: 'api/studentDocuments/demands',
        token: CacheHelper.getData(key: 'token')).then((value) {
      print('demands ,${value}');
      List demands=value.data;
      allDemands=demands.map((e) =>
      demandModel = DemandModel.fromJson(e)).toList();
      emit(DemandsLoadingDataSuccess(demandModel));
    }).catchError((error) async {
      print(error.toString());
      emit(DemandsLoadingDataError(error.toString()));
    });
  }

  NoticeModel? noticeModel;
  List<NoticeModel> allNotices= [];
  Future<void> getNotices() async {
    emit(LoadingNoticesDataState());
    print('recherche en cours');
    final token=CacheHelper.getData(key: "token");
    DioHelper.getData(
        url: 'api/studentDocuments/notices',
        token:  CacheHelper.getData(key: 'token')).then((value) {
      print('Notices ,$value');
      List notices=value.data;
      allNotices=notices.map((e) =>
      noticeModel =  NoticeModel.fromJson(e)).toList();
      emit(NoticesLoadingDataSuccess());
    }).catchError((error) async {
      print(error.toString());
      emit(NoticesLoadingDataError(error.toString()));
    });
  }

  void downloadNotice(document) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();
      final id = await FlutterDownloader.enqueue(
        url: document.toString(),
        savedDir: externalDir!.path,
        fileName: "Avis",
        showNotification: true,
        openFileFromNotification: true,

      );
    } else {
      print('Permission Denied');
    }
  }


  var newProfileImage;
  Future<void> getProfileImage (ImageSource source) async{
    ImagePicker _picker = ImagePicker();
    print('here');
    try{
      newProfileImage = await _picker.pickImage(source: source) ;
      if (newProfileImage != null) {
       // uploadImage (newProfileImage);
        uploadImageCloudinary(newProfileImage!.path);
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

  String? imageUrlCloudinary;
  void uploadImageCloudinary (String path)  async{
    imageUrlCloudinary = '';
    emit(SchoolUploadProfileImageCloudinaryLoadingState());
    final cloudinary = CloudinaryPublic('dmbpqddpn', 'ml_default', cache: false);

    await cloudinary.uploadFile(
      CloudinaryFile.fromFile(path, resourceType: CloudinaryResourceType.Image),
    ).then((response) {
      imageUrlCloudinary = response.secureUrl;
      print('the uploaded file');
      print(response.secureUrl);
      emit(SchoolUploadProfileImageCloudinarySuccessState());
    }).catchError((err){
      print(err.message);
      print(err.request);
      emit(SchoolUploadProfileImageCloudinaryErrorState());
    });

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

  Future <void> updateProfile(
      { String? government,  String? password, String? email, String? country, String? phone,String? adress,String? avatar}) async {
    print('update now');
    emit(updateProfileAddingDataLoadingState());
    final token = CacheHelper.getData(key: "token");
    print('token,$token');
    DioHelper.putData(
        url: 'api/authStudent/updateProfile', token:token, data: {
        'government': government,
        'email': email,
        'country': country,
        'phone': phone,
        'adress': adress,
        'password': password,
      'avatar':avatar
      },
      ).then((value) {
        print(value);
        emit(updateProfileAddingDataSuccess(studentData));
      }).catchError((error) async {
        print(error.toString());
        emit(updateProfileAddinggDataError(error.toString()));
      });


  }


}

