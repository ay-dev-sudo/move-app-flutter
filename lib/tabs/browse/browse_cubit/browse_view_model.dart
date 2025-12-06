import 'package:bloc/bloc.dart';
import '../../../api/api_service .dart';
import '../../../model/MoviesResponse.dart';
import 'browse_states.dart';

class BrowseViewModel extends Cubit<BrowseStates> {
  BrowseViewModel() : super(BrowseInitialState());

  List<Movies> moviesList = [];
  List<dynamic> genres = [];
  List<Movies> moviesByGenre = [];
  int selectedIndex = 0;

  String? genreFromArgs;


  Future<void> loadMovies() async {
    emit(BrowseLoadingState());
    try {
      final response = await ApiService().getMovieList(limit: 50);
      moviesList = response.data?.movies ?? [];

      final allGenres = moviesList.expand((m) => m.genres ?? []).toList();
      genres = allGenres.toSet().toList()..sort();

      if (genreFromArgs != null && genres.contains(genreFromArgs)) {
        selectedIndex = genres.indexOf(genreFromArgs!);
      } else {
        selectedIndex = 0;
        genreFromArgs = genres[0];
      }

      await loadMoviesByGenre(genreFromArgs!);

      emit(BrowseSuccessState());
    } catch (e) {
      emit(BrowseErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> loadMoviesByGenre(String genre) async {
    emit(BrowseLoadingState());
    try {
      final response = await ApiService().getMovieList(genre: genre, limit: 50);
      moviesByGenre = response.data?.movies ?? [];
      genreFromArgs = genre;
      selectedIndex = genres.indexOf(genre);
      emit(BrowseSuccessState());
    } catch (e) {
      emit(BrowseErrorState(errorMessage: e.toString()));
    }
  }
}
