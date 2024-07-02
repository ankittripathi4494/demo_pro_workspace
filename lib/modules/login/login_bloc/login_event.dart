// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginEvent {}

//First Event
class LoginFormTextChangeEvent extends LoginEvent {
  late final String usernameValue;
  late final String passwordValue;
  LoginFormTextChangeEvent({
    required this.usernameValue,
    required this.passwordValue,
  });
}
//Second Event
class LoginFormSubmitEvent extends LoginEvent {
  late final String usernameValue;
  late final String passwordValue;
  LoginFormSubmitEvent({
    required this.usernameValue,
    required this.passwordValue,
  });
}
