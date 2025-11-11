import 'package:flutter/material.dart';
import 'package:move/l10n/app_localizations.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_fonts.dart';
import 'package:move/utils/app_routs.dart';
import 'package:move/widget/custom_bottom.dart';
import 'package:move/widget/custom_text_faild.dart';

import '../../../utils/app_color.dart';
import 'bottom_sheet_avatar.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});


  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String oldSelectedAvatar = AppAssets.A8;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.pickAvatar, style: AppFonts.regular20yellow),
        centerTitle: true,
        backgroundColor: AppColor.black,
        iconTheme: IconThemeData(color: AppColor.yellow),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.04),
              InkWell(
                onTap: () async {
                  final selectedAvatar =
                  await BottomSheetAvatar.show(context: context);
                    setState(() {
                      oldSelectedAvatar = selectedAvatar;
                    });

                },
                child: Container(decoration: BoxDecoration(
                    shape: BoxShape.circle,
                ),
                  child: Image.asset(oldSelectedAvatar, scale: 0.6),
                ),
              ),
              SizedBox(height: height * 0.04),
              CustomTextField(
                hint: "John Safwat",
                isPassword: false,
                controller: nameController,
                icon: Image.asset(AppAssets.name),
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                hint: "01200000000",
                isPassword: false,
                controller: phoneController,
                icon: Image.asset(AppAssets.phone),
              ),
              SizedBox(height: height * 0.02),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRouts.resetPasswordRouteName);
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(AppLocalizations.of(context)!.resetPassword,
                      style: AppFonts.regular20white),
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
              ),
              SizedBox(height: height * 0.02),
              CustomButton(
                text: AppLocalizations.of(context)!.updateData,
                color: AppColor.yellow,
                borderColor: Colors.yellow,
                width: width * 0.93,
                height: height * 0.06,
                textFont: AppFonts.regular20black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
