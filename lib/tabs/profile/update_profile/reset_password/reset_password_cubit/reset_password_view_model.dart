import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:move/tabs/profile/update_profile/reset_password/reset_password_cubit/reset_password_states.dart';

import 'package:move/tabs/profile/update_profile/update_profile_cubit/update_profile_states.dart';

import '../../../../../api/api_service .dart';
import '../../../../../shared_helper/shared_helper.dart';



class ResetPasswordViewModel extends Cubit<ResetPasswordStates> {
  ResetPasswordViewModel() : super(ResetPasswordInitialState());

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

  Future<void> resetPassword() async {
    if (newPasswordController.text != confirmNewPasswordController.text) {
      emit(ResetPasswordErrorState("newPasswordController not equal confirmNewPasswordController"));
      return;
    }
    emit(ResetPasswordLoadingState());
    try {
      final token = await SharedHelper.getToken();

      final response = await ApiService().resetPassword(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
        token: token,
      );

      emit(ResetPasswordSuccessState( "Password updated successfully"));

    } catch (e) {
      emit(ResetPasswordErrorState(e.toString()));
    }
  }
}

