import 'package:bloc/bloc.dart';
import '../../../../api/api_service .dart';
import '../../../../model/MovieDetailsResponse.dart';
import '../../../../model/MovieSuggestionsResponse.dart';
import 'movie_details_screen_states.dart';

class MovieDetailsScreenViewModel extends Cubit<MovieDetailsScreenStates> {
  MovieDetailsScreenViewModel() : super(MovieDetailsInitialState());

  Movie? movieDetails;
  List<Movies> suggestions = [];
  bool? isFavorite;

  Future<void> loadMovieDetails(int movieId) async {
    try {
      emit(MovieDetailsLoadingState());
      final response = await ApiService().getMovieDetails(movie_id: movieId);
      movieDetails = response.data?.movie;

      emit(MovieDetailsSuccessState(movieDetails!));
    } catch (e) {
      emit(MovieDetailsErrorState(errorMessage: e.toString()));
    }
  }
  Future<void> loadMovieSuggestions(int movieId) async {
    try {
      emit(MovieSuggestionsLoadingState());
      final response = await ApiService().getMovieSuggestions(movie_id: movieId);
      suggestions = response.data?.movies ?? [];
      emit(MovieSuggestionsSuccessState(suggestions));
    } catch (e) {
      emit(MovieDetailsErrorState(errorMessage: e.toString()));
    }
  }
  Future<void> loadFavoriteStatus(int movieId) async {
    try {
      emit(MovieDetailsLoadingState());
      final response = await ApiService().movieIsFavorite(movieId: movieId);
      isFavorite = response.data;
      emit(FavoriteStatusSuccessState(isFavorite ?? false));
    } catch (e) {
      emit(MovieDetailsErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> addToFavorite() async {
    if (movieDetails == null) return;
    try {
      emit(FavoriteStatusLoadingState());
      await ApiService().addMovieToFavorite(
        movieId: movieDetails!.id,
        name: movieDetails!.title ?? "",
        rating: movieDetails!.rating ?? 0.0,
        imageURL: movieDetails!.mediumCoverImage ?? "",
        year: movieDetails!.year ?? 0,
      );
      isFavorite = true;
      emit(FavoriteStatusSuccessState(isFavorite!));
    } catch (e) {
      emit(MovieDetailsErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> removeFromFavorite() async {
    if (movieDetails == null) return;
    try {
      emit(FavoriteStatusLoadingState());
      await ApiService().removeMovie(movieId: movieDetails!.id);
      isFavorite = false;
      emit(FavoriteStatusSuccessState(isFavorite!));
    } catch (e) {
      emit(MovieDetailsErrorState(errorMessage:e.toString()));
    }
  }
}
