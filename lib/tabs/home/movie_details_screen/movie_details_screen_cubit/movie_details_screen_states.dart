import '../../../../model/MovieDetailsResponse.dart';
import '../../../../model/MovieSuggestionsResponse.dart';

abstract class MovieDetailsScreenStates {}

class MovieDetailsInitialState extends MovieDetailsScreenStates {}

class MovieDetailsLoadingState extends MovieDetailsScreenStates {}

class MovieDetailsErrorState extends MovieDetailsScreenStates {
  final String errorMessage;
  MovieDetailsErrorState({required this.errorMessage});
}

class MovieDetailsSuccessState extends MovieDetailsScreenStates {
  final Movie movieDetails;
  MovieDetailsSuccessState(this.movieDetails);
}

class MovieSuggestionsLoadingState extends MovieDetailsScreenStates {}

class MovieSuggestionsSuccessState extends MovieDetailsScreenStates {
  final List<Movies> suggestions;
  MovieSuggestionsSuccessState(this.suggestions);
}

class FavoriteStatusLoadingState extends MovieDetailsScreenStates {}

class FavoriteStatusSuccessState extends MovieDetailsScreenStates {
  final bool isFavorite;
  FavoriteStatusSuccessState(this.isFavorite);
}
