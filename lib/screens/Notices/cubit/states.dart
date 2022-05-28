
abstract class  NoticesStates {}
class NoticestInitialState extends NoticesStates {}
class LoadingNoticesDataState extends NoticesStates {}
class NoticesLoadingDataSuccess extends NoticesStates {
  // final StudentModel? studentModel ;

  NoticesLoadingDataSuccess();
}
class NoticesLoadingDataError extends NoticesStates {
  late String error ;
  NoticesLoadingDataError(this.error);
}