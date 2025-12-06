import 'package:move/model/GetAllFavoritesMovies.dart';
import 'package:move/model/GetProfile.dart';

abstract class UpdateProfileStates {}

class UpdateProfileInitialState extends UpdateProfileStates {}

class  UpdateProfileLoadingState extends UpdateProfileStates {}

class  UpdateProfileErrorState extends UpdateProfileStates {
  final String message;
  UpdateProfileErrorState(this.message);
}
class UpdateProfileSuccessState extends UpdateProfileStates {
  final String message;
  UpdateProfileSuccessState(this.message);
}
class UpdateProfileLoadedState extends UpdateProfileStates {
  final String avatar;
  final String name;
  final String phone;

  UpdateProfileLoadedState({
    required this.avatar,
    required this.name,
    required this.phone,
  });
}
