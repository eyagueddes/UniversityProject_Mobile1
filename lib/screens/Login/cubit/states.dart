

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangeState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates
{


  LoginSuccessState();
}

class LoginErrorState extends LoginStates
{
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends LoginStates {}