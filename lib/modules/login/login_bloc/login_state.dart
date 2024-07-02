// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginState {}

final class LoginInitial extends LoginState {}

//State for First Event

class LoginFormTextChangeLoadingState extends LoginState {}

class LoginFormTextValidState extends LoginState {}

class LoginFormTextChangeErrorState extends LoginState {
  late String? usernameError;
  late String? passwordError;
   
  LoginFormTextChangeErrorState({
    required this.usernameError,
    required this.passwordError,
    
  });
}


//State for Second Event

class LoginFormSubmitLoadingState extends LoginState {}

class LoginFormSubmitSuccessState extends LoginState {
   late String? successMesaage;
  LoginFormSubmitSuccessState({
    required this.successMesaage,
  });
}

class LoginFormSubmitFailedState extends LoginState {
  late String? usernameError;
  late String? passwordError;
  late String? commonError;
  LoginFormSubmitFailedState({
    required this.usernameError,
    required this.passwordError,
    required this.commonError,
  });
}
