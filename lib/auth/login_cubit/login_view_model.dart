import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../api/api_service .dart';
import '../../shared_helper/shared_helper.dart';
import '../../widget/alert_dialog_utils.dart';
import '../auth_states.dart';


class LoginViewModel extends Cubit<AuthStates> {
  final TextEditingController emailCtrl = TextEditingController(
    text: "samer99@gmail.com",
  );

  final TextEditingController passwordCtrl = TextEditingController(
    text: "Samer@123456",
  );

  LoginViewModel() : super(AuthInitialState());

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> login() async {
    if (formkey.currentState?.validate() == true) {
      try {
        emit(AuthLoadingState());

        final response = await ApiService().login(
          email: emailCtrl.text,
          password: passwordCtrl.text,
        );

        String message = response.message ?? "Success";

        if (message == "Success Login") {
          SharedHelper.setToken("${response.data}");
        }

        emit(AuthSuccessState(message));

      } catch (e) {
        String errorMessage = "Unexpected error";

        if (e is DioException) {
          errorMessage = e.response?.data["message"] ?? e.message ?? errorMessage;
        } else {
          errorMessage = e.toString();
        }

        emit(AuthErrorState(errorMessage: errorMessage));
      }
    }
  }

  Future<void> loginWithGoogle() async {
    emit(AuthLoadingState());

    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account != null) {
        emit(AuthSuccessState("Success login with Google"));
      } else {
        emit(AuthErrorState(errorMessage: "Login canceled"));
      }
    } catch (e) {
      emit(AuthErrorState(errorMessage: "Error: $e"));
    }
  }
}
