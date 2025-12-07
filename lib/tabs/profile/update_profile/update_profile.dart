import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/l10n/app_localizations.dart';
import 'package:move/tabs/profile/update_profile/update_profile_cubit/update_profile_states.dart';
import 'package:move/tabs/profile/update_profile/update_profile_cubit/update_profile_view_model.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_fonts.dart';
import 'package:move/utils/app_routs.dart';
import 'package:move/widget/custom_bottom.dart';
import 'package:move/widget/custom_text_faild.dart';

import '../../../utils/app_color.dart';
import 'bottom_sheet_avatar.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  UpdateProfileViewModel viewModel=UpdateProfileViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.loadProfileData();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.pickAvatar,
          style: AppFonts.regular20yellow,
        ),
        centerTitle: true,
        backgroundColor: AppColor.black,
        iconTheme: IconThemeData(color: AppColor.yellow),
      ),

      body: BlocListener<UpdateProfileViewModel, UpdateProfileStates>(
        bloc: viewModel,
        listener: (context, state) {
          if (state is UpdateProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: AppColor.red, content: Text(state.message)),
            );
          }

          if (state is UpdateProfileSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: AppColor.green, content: Text(state.message)),
            );
          }
        },

        child: BlocBuilder<UpdateProfileViewModel, UpdateProfileStates>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is UpdateProfileLoadingState) {
              return  Center(
                child: CircularProgressIndicator(color: Colors.yellow),
              );
            }

            if (state is UpdateProfileLoadedState) {
              viewModel.nameController.text = state.name;
              viewModel.phoneController.text = state.phone;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.04),
                    InkWell(
                      onTap: () async {
                        final selectedAvatar =
                        await BottomSheetAvatar.show(context: context);
                        viewModel.selectAvatar(selectedAvatar);
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(state.avatar),
                      ),
                    ),

                    SizedBox(height: height * 0.04),

                    CustomTextField(
                      hint: "Name",
                      isPassword: false,
                      controller: viewModel.nameController,
                      icon: Image.asset(AppAssets.name),
                    ),

                    SizedBox(height: height * 0.02),

                    CustomTextField(
                      hint: "Phone",
                      isPassword: false,
                      controller: viewModel.phoneController,
                      icon: Image.asset(AppAssets.phone),
                    ),

                    SizedBox(height: height * 0.02),

                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRouts.resetPasswordRouteName);
                      },
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppLocalizations.of(context)!.resetPassword,
                          style: AppFonts.regular20white,
                        ),
                      ),
                    ),

                    const Spacer(),

                    CustomButton(
                      text: AppLocalizations.of(context)!.deleteAccount,
                      color: AppColor.red,
                      borderColor: Colors.red,
                      width: width * 0.93,
                      height: height * 0.06,
                      textFont: AppFonts.regular20white,
                      onTap: () {
                        viewModel.deleteProfile(context);
                        Navigator.of(context).pushReplacementNamed( AppRouts.loginRouteName);

                      },
                    ),

                    SizedBox(height: height * 0.02),

                    CustomButton(
                      text: AppLocalizations.of(context)!.updateData,
                      color: AppColor.yellow,
                      borderColor: Colors.yellow,
                      width: width * 0.93,
                      height: height * 0.06,
                      textFont: AppFonts.regular20black,
                      onTap: () {
                        viewModel.updateProfile(
                          name: viewModel.nameController.text,
                          phone: viewModel.phoneController.text,
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            return  SizedBox();
          },
        ),
      ),
    );
  }
}

