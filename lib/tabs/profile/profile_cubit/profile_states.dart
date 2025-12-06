import 'package:move/model/GetAllFavoritesMovies.dart';
import 'package:move/model/GetProfile.dart';

import '../../../model/MoviesResponse.dart';

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileErrorState extends ProfileStates {
  final String message;
  ProfileErrorState(this.message);
}

class ProfileSuccessState extends ProfileStates {
  final GetProfile profile;
  final List<Map<String, dynamic>> savedMovies;
  final List<Data> favoriteMovies;

  ProfileSuccessState({
    required this.profile,
    required this.savedMovies,
    required this.favoriteMovies,
  });
}
