
import '../../../model/MoviesResponse.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeErrorState extends HomeStates {
  final String errorMessage;
  HomeErrorState({required this.errorMessage});
}

class ChangeCurrentIndexState extends HomeStates {
}

class LatestMoviesSuccessState extends HomeStates {
  final List<Movies> latestMovies;
  LatestMoviesSuccessState(this.latestMovies);
}

class GenreMoviesSuccessState extends HomeStates {
  final String genre;
  final List<Movies> genreMovies;
  GenreMoviesSuccessState(this.genre, this.genreMovies);
}
class GenreMoviesLoadingState extends HomeStates {
}
