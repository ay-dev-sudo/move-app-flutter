import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_fonts.dart';
import '../../../../widget/custom_bottom.dart';
import '../../../../widget/custom_text_faild.dart';

class ResetPassword extends StatelessWidget {
   ResetPassword({super.key});
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        //   toolbarHeight: 30,
        title: Text(AppLocalizations.of(context)!.resetPassword, style: AppFonts.regular20yellow),
        centerTitle: true,
        backgroundColor: AppColor.black,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColor.yellow),
      ),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.04),
                CustomTextField(hint: AppLocalizations.of(context)!.oldPassword,
                    isPassword: true,
                    controller: oldPasswordController,
                    icon: Image.asset(AppAssets.pas)),
                SizedBox(height: height * 0.04),
                CustomTextField(hint: AppLocalizations.of(context)!.newPassword,
                    isPassword: true,
                    controller: newPasswordController,
                    icon: Image.asset(AppAssets.pas)),
                SizedBox(height: height * 0.04),

                CustomTextField(hint: AppLocalizations.of(context)!.confirmNewPassword,
                    isPassword: true,
                    controller: confirmNewPasswordController,
                    icon: Image.asset(AppAssets.pas)),
                SizedBox(height: height * 0.02,),
                Spacer(),
                CustomButton(text: AppLocalizations.of(context)!.resetPassword,
                    color: AppColor.red,
                    borderColor: Colors.red,
                    width: width * 0.93,
                    height: height * 0.06,
                    textFont: AppFonts.regular20white,
                onTap:() {
                  Navigator.pop(context);
                },
                  ),
                SizedBox(height: height * 0.02,),


              ],
            ),
          )

      ),
    );
  }
}