import 'dart:math';
import 'package:bloc/bloc.dart';
import '../../../api/api_service .dart';
import '../../../model/MoviesResponse.dart';

import 'home_states.dart';

class HomeViewModel extends Cubit<HomeStates> {
  HomeViewModel() : super(HomeInitialState());

  String genre = '';
  int currentIndex = 0;

  List<Movies> latestMoviesList = [];
  List<Movies> genreMoviesList = [];



  Future<List<Movies>> loadLatestMovies() async {
    emit(HomeLoadingState());
    final response = await ApiService().getMovieList(sort_by: "date_added");
    latestMoviesList = response.data?.movies ?? [];
    emit(LatestMoviesSuccessState(latestMoviesList));
    return latestMoviesList;
  }


  Future<List<Movies>> loadGenreMovies() async {
    emit(GenreMoviesLoadingState());
    final response = await ApiService().getMovieList();
    final allMovies = response.data?.movies ?? [];

    if (allMovies.isEmpty) return [];

    final allGenres = allMovies.expand((movie) => movie.genres ?? []).toList();
    if (allGenres.isEmpty) return [];
    final randomGenre = allGenres[Random().nextInt(allGenres.length)];
    final genreResponse = await ApiService().getMovieList(genre: randomGenre);

    genre = randomGenre;
    genreMoviesList = genreResponse.data?.movies ?? [];

    emit(GenreMoviesSuccessState(genre, genreMoviesList));
    return genreMoviesList;
  }
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexState());
  }
}
