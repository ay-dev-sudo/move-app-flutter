import '../../../model/MoviesResponse.dart';

abstract class BrowseStates {}

class BrowseInitialState extends BrowseStates {}

class BrowseLoadingState extends BrowseStates {}

class BrowseSuccessState extends BrowseStates {}

class BrowseErrorState extends BrowseStates {
  final String errorMessage;
  BrowseErrorState({required this.errorMessage});
}
