import 'package:move/model/GetAllFavoritesMovies.dart';
import 'package:move/model/GetProfile.dart';

abstract class ResetPasswordStates {}

class  ResetPasswordInitialState extends ResetPasswordStates {}

class   ResetPasswordLoadingState extends ResetPasswordStates {}

class  ResetPasswordErrorState extends ResetPasswordStates {
  final String message;
  ResetPasswordErrorState(this.message);
}
class  ResetPasswordSuccessState extends ResetPasswordStates {
  final String response;
  ResetPasswordSuccessState(this.response);
}

