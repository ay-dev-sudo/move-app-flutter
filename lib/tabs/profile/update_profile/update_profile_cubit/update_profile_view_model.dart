import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:move/tabs/profile/update_profile/update_profile_cubit/update_profile_states.dart';

import '../../../../api/api_service .dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_routs.dart';


class UpdateProfileViewModel extends Cubit<UpdateProfileStates> {
  UpdateProfileViewModel() : super(UpdateProfileInitialState());

  String myAvatar = AppAssets.A8;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Future<void> loadProfileData() async {
    emit(UpdateProfileLoadingState());
    try {
      final response = await ApiService().getProfile();
      if (response?.data != null) {
        final user = response!.data!;
        myAvatar = getAvatarFromId(user.avaterId ?? 8);
        emit(UpdateProfileLoadedState(
          avatar: myAvatar,
          name: user.name ?? "",
          phone: user.phone ?? "",
        ));
      }
    } catch (e) {
      emit(UpdateProfileErrorState(e.toString()));
    }
  }

  Future<void> selectAvatar(String asset) async {
    myAvatar = asset;
    final response = await ApiService().getProfile();
    final user = response!.data!;
    emit(UpdateProfileLoadedState(
      avatar: myAvatar,
      name: user.name??"",
      phone:user.phone??"",
    ));
  }
  Future<void> updateProfile({required String name, required String phone}) async {
    emit(UpdateProfileLoadingState());
    try {
      final avatarId = getAvatarIdFromAsset(myAvatar);
      final response = await ApiService().updateProfile(
        name: name,
        phone: phone,
        avaterId: avatarId,
      );
      emit(UpdateProfileSuccessState(response));
      await loadProfileData();

    } catch (e) {
      emit(UpdateProfileErrorState(e.toString()));
    }
  }

  Future<void> deleteProfile(BuildContext context) async {
    try {
      final response = await ApiService().delProfile();
      emit(UpdateProfileSuccessState(response ?? "Deleted successfully"));
    } catch (e) {
      emit(UpdateProfileErrorState(e.toString()));
    }
  }

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

  int getAvatarIdFromAsset(String asset) {
    switch (asset) {
      case AppAssets.A1: return 1;
      case AppAssets.A2: return 2;
      case AppAssets.A3: return 3;
      case AppAssets.A4: return 4;
      case AppAssets.A5: return 5;
      case AppAssets.A6: return 6;
      case AppAssets.A7: return 7;
      case AppAssets.A8: return 8;
      case AppAssets.A9: return 9;
      default: return 8;
    }
  }
}

