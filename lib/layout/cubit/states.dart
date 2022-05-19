import 'package:university_project_mobile/models/student.dart';

import '../../models/student.dart';

abstract class SchoolStates {}
class SchoolInitialState extends SchoolStates {}
class SchoolChangeIndexBottomNavBar extends SchoolStates {}
class SchoolLoadingUserDataState extends SchoolStates {}
class SchoolUserLoadingDataSuccess extends SchoolStates {
  final StudentModel? studentModel ;

  SchoolUserLoadingDataSuccess(this.studentModel);
}
class SchoolUserLoadingDataError extends SchoolStates {
  late String error ;
  SchoolUserLoadingDataError(this.error);
}