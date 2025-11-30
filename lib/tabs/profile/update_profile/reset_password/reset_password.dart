import 'package:flutter/material.dart';
import 'package:move/shared_helper/shared_helper.dart';
import '../../../../api/api_service .dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_fonts.dart';
import '../../../../widget/custom_bottom.dart';
import '../../../../widget/custom_text_faild.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.resetPassword,
            style: AppFonts.regular20yellow),
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
              CustomTextField(
                hint: AppLocalizations.of(context)!.oldPassword,
                isPassword: true,
                controller: oldPasswordController,
                icon: Image.asset(AppAssets.pas),
              ),
              SizedBox(height: height * 0.04),
              CustomTextField(
                hint: AppLocalizations.of(context)!.newPassword,
                isPassword: true,
                controller: newPasswordController,
                icon: Image.asset(AppAssets.pas),
              ),
              SizedBox(height: height * 0.04),
              CustomTextField(
                hint: AppLocalizations.of(context)!.confirmNewPassword,
                isPassword: true,
                controller: confirmNewPasswordController,
                icon: Image.asset(AppAssets.pas),
              ),
              SizedBox(height: height * 0.02),
              Spacer(),
              CustomButton(
                text: AppLocalizations.of(context)!.resetPassword,
                color: AppColor.red,
                borderColor: Colors.red,
                width: width * 0.93,
                height: height * 0.06,
                textFont: AppFonts.regular20white,
                  onTap: () async {
                    if (newPasswordController.text != confirmNewPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(backgroundColor: AppColor.red,content: Text("Passwords do not match")),
                      );
                      return;
                    }
                    try {
                      var token= SharedHelper.getToken();
                      final response = await ApiService().resetPassword(
                        oldPassword: oldPasswordController.text,
                        newPassword: newPasswordController.text,
                        token: await token,
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(backgroundColor: AppColor.green,content: Text(response)),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(backgroundColor: AppColor.red,content: Text(e.toString())),
                      );
                    }
                  }
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
