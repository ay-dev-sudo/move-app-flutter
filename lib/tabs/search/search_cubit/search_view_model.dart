import 'package:bloc/bloc.dart';
import '../../../model/MoviesResponse.dart';
import '../../../api/api_service .dart';
import 'search_states.dart';

class SearchViewModel extends Cubit<SearchStates> {
  SearchViewModel() : super(SearchInitialState());

  List<Movies> movieList = [];

  void loadMovies({String? searchByName}) async {
    try {
      emit(SearchLoadingState());
      final response = await ApiService().getMovieList(
        limit: 50,
        searchByName: searchByName,
      );
      movieList = response.data?.movies ?? [];
      emit(SearchLoadedState());
    } catch (e) {
      emit(SearchErrorState(errorMessage: e.toString()));
    }
  }
}
