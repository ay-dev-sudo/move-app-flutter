abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}
class AvatarErrorState extends AuthStates {
  final String errorMessage;
  AvatarErrorState({required this.errorMessage});
}

class AuthErrorState extends AuthStates {
  final String errorMessage;
  AuthErrorState({required this.errorMessage});
}

class AuthSuccessState extends AuthStates {
  final String message;
  AuthSuccessState(this.message);
}


