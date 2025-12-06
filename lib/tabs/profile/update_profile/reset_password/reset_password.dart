import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/shared_helper/shared_helper.dart';
import 'package:move/tabs/profile/update_profile/reset_password/reset_password_cubit/reset_password_states.dart';
import 'package:move/tabs/profile/update_profile/reset_password/reset_password_cubit/reset_password_view_model.dart';
import '../../../../api/api_service .dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_fonts.dart';
import '../../../../widget/custom_bottom.dart';
import '../../../../widget/custom_text_faild.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final ResetPasswordViewModel viewModel = ResetPasswordViewModel();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.resetPassword,
          style: AppFonts.regular20yellow,
        ),
        centerTitle: true,
        backgroundColor: AppColor.black,
        iconTheme: IconThemeData(color: AppColor.yellow),
      ),

      body: BlocListener<ResetPasswordViewModel, ResetPasswordStates>(
        bloc: viewModel,
        listener: (context, state) {
          if (state is ResetPasswordErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: AppColor.red, content: Text(state.message)),
            );
          }

          if (state is ResetPasswordSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: AppColor.green, content: Text(state.response)),
            );
            Navigator.pop(context);
          }
        },

        child: BlocBuilder<ResetPasswordViewModel, ResetPasswordStates>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is ResetPasswordLoadingState) {
              return  Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Column(
                children: [
                  SizedBox(height: height * 0.04),

                  CustomTextField(
                    hint: AppLocalizations.of(context)!.oldPassword,
                    isPassword: true,
                    controller: viewModel.oldPasswordController,
                    icon: Image.asset(AppAssets.pas),
                  ),

                  SizedBox(height: height * 0.04),

                  CustomTextField(
                    hint: AppLocalizations.of(context)!.newPassword,
                    isPassword: true,
                    controller: viewModel.newPasswordController,
                    icon: Image.asset(AppAssets.pas),
                  ),

                  SizedBox(height: height * 0.04),

                  CustomTextField(
                    hint: AppLocalizations.of(context)!.confirmNewPassword,
                    isPassword: true,
                    controller: viewModel.confirmNewPasswordController,
                    icon: Image.asset(AppAssets.pas),
                  ),

                  const Spacer(),

                  CustomButton(
                    text: AppLocalizations.of(context)!.resetPassword,
                    color: AppColor.red,
                    borderColor: Colors.red,
                    width: width * 0.93,
                    height: height * 0.06,
                    textFont: AppFonts.regular20white,
                    onTap: () => viewModel.resetPassword(),
                  ),

                  SizedBox(height: height * 0.02),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

