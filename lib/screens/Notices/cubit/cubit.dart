import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_mobile/screens/Notices/cubit/states.dart';
import '../../../helper/cache_helper.dart';
import '../../../helper/network/dioHelper.dart';

class NoticesCubit extends Cubit<NoticesStates> {
  NoticesCubit() : super(NoticestInitialState());

  static NoticesCubit get(context) => BlocProvider.of(context);
  Future<void> getNotices() async {
    emit(LoadingNoticesDataState());
    print('recherche en cours');
    final token=CacheHelper.getData(key: "token");
    DioHelper.getData(
        url: 'api/studentDocuments/notices',
        token:  CacheHelper.getData(key: 'token')).then((value) {
      print('Notices ,$value');
      // studentModel =  StudentModel.fromJson(value.data);
      emit(NoticesLoadingDataSuccess());
    }).catchError((error) async {
      print(error.toString());
      emit(NoticesLoadingDataError(error.toString()));
    });
  }

}
