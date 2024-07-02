import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final String userContact = "6392216480";
  final String userpassword = "Ankit@123";
  LoginBloc() : super(LoginInitial()) {
    on<LoginFormTextChangeEvent>((event, emit) {
      if (event.usernameValue.isEmpty && event.passwordValue.isEmpty) {
        emit(LoginFormTextChangeErrorState(
            usernameError: "Please Enter Username",
            passwordError: "Please Enter Password"));
      } else if (event.usernameValue.isEmpty &&
          event.passwordValue.isNotEmpty) {
        emit(LoginFormTextChangeErrorState(
            usernameError: "Please Enter Username", passwordError: null));
      } else if (event.usernameValue.isNotEmpty &&
          event.passwordValue.isEmpty) {
        emit(LoginFormTextChangeErrorState(
            usernameError: null, passwordError: "Please Enter Password"));
      } else if (event.usernameValue.length < 10) {
        emit(LoginFormTextChangeErrorState(
            usernameError: "Please Enter Username upto 10 digits",
            passwordError: null));
      } else {
        emit(LoginFormTextValidState()); // no error
      }
    });

    on<LoginFormSubmitEvent>((event, emit) {
      if ((event.usernameValue
                  .toString()
                  .trim()
                  .toLowerCase()
                  .compareTo(userContact.toString().trim().toLowerCase()) !=
              0) &&
          (event.passwordValue
                  .toString()
                  .trim()
                  .toLowerCase()
                  .compareTo(userpassword.toString().trim().toLowerCase()) !=
              0)) {
        emit(LoginFormSubmitFailedState(
            usernameError: null,
            passwordError: null,
            commonError: "Username and password is incorrect"));
      } else if ((event.usernameValue
                  .toString()
                  .trim()
                  .toLowerCase()
                  .compareTo(userContact.toString().trim().toLowerCase()) ==
              0) &&
          (event.passwordValue
                  .toString()
                  .trim()
                  .toLowerCase()
                  .compareTo(userpassword.toString().trim().toLowerCase()) !=
              0)) {
        emit(LoginFormSubmitFailedState(
            usernameError: null,
            passwordError: "Password is incorrect",
            commonError: null));
      } else if ((event.usernameValue
                  .toString()
                  .trim()
                  .toLowerCase()
                  .compareTo(userContact.toString().trim().toLowerCase()) !=
              0) &&
          (event.passwordValue
                  .toString()
                  .trim()
                  .toLowerCase()
                  .compareTo(userpassword.toString().trim().toLowerCase()) ==
              0)) {
        emit(LoginFormSubmitFailedState(
            usernameError: "Username is incorrect",
            passwordError: null,
            commonError: null));
      } else {
        
        emit(LoginFormSubmitSuccessState(
            successMesaage: "Login is Successfull"));
      }
    });
  }
}
