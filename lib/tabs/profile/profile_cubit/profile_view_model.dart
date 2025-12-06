import 'package:bloc/bloc.dart';
import 'package:move/shared_helper/shared_helper.dart';
import 'package:move/tabs/profile/profile_cubit/profile_states.dart';
import '../../../api/api_service .dart';
import '../../../utils/app_assets.dart';

class ProfileViewModel extends Cubit<ProfileStates> {
  ProfileViewModel() : super(ProfileInitialState());

  String getAvatarFromId(int id) {
    switch (id) {
      case 1: return AppAssets.A1;
      case 2: return AppAssets.A2;
      case 3: return AppAssets.A3;
      case 4: return AppAssets.A4;
      case 5: return AppAssets.A5;
      case 6: return AppAssets.A6;
      case 7: return AppAssets.A7;
      case 8: return AppAssets.A8;
      case 9: return AppAssets.A9;
      default: return AppAssets.A8;
    }
  }

  Future<void> loadAllData() async {
    emit(ProfileLoadingState());
    try {
      var profile = await ApiService().getProfile();
      var favorites = await ApiService().getAllFavoritesMovies();
      var savedMovies = await SharedHelper.getSavedMovies();
      emit(ProfileSuccessState(
        profile: profile!,
        favoriteMovies: favorites.data ?? [],
        savedMovies: savedMovies,
      ));

    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
}
