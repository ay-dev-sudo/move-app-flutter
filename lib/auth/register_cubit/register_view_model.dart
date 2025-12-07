import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../api/api_service .dart';
import '../../utils/app_assets.dart';
import '../auth_states.dart';

class RegisterViewModel extends Cubit<AuthStates> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl = TextEditingController(text: "samer");
  final TextEditingController emailCtrl = TextEditingController(text: "samer8989@gmail.com");
  final TextEditingController passwordCtrl = TextEditingController(text: "Samer@1234");
  final TextEditingController confirmPasswordCtrl = TextEditingController(text: "Samer@1234");
  final TextEditingController phoneCtrl = TextEditingController(text: "01285036048");
  int currentIndex = 0;
  int? selectedIndex;

  int? avatarIndex;
  final List<String> images = [
    AppAssets.A1,
    AppAssets.A2,
    AppAssets.A3,
    AppAssets.A4,
    AppAssets.A5,
    AppAssets.A6,
    AppAssets.A7,
    AppAssets.A8,
    AppAssets.A9,
  ];


  RegisterViewModel() : super(AuthInitialState());

  Future<void> register() async {


    String phone = phoneCtrl.text.trim();
    if (!phone.startsWith('+')) {
      phone = '+2$phone';
    }

    try {
      if (formKey.currentState?.validate() == true) {
        emit(AuthLoadingState());
        if (avatarIndex == null) {
          emit(AvatarErrorState(errorMessage: "Please select an avatar"));
          return;
        }
        final response = await ApiService().register(
          name: nameCtrl.text,
          email: emailCtrl.text,
          password: passwordCtrl.text,
          phone: phone,
          avatarId: avatarIndex!,
        );

        if (response.message == "User created successfully") {
          emit(AuthSuccessState(response.message!));
        } else {
          emit(AuthErrorState(
              errorMessage: response.message ?? "Unknown error"));
        }
      }
    } catch (e) {
      String errorMessage = "Something went wrong";

      if (e is DioException) {
        errorMessage = e.response?.data["message"] ?? e.message ?? errorMessage;
      } else {
        errorMessage = e.toString();
      }

      emit(AuthErrorState(errorMessage: errorMessage));
    }
  }


}
