import '../../../model/MoviesResponse.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchLoadedState extends SearchStates {}

class SearchErrorState extends SearchStates {
  final String errorMessage;
  SearchErrorState({required this.errorMessage});
}
