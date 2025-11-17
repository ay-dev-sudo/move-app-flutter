import 'package:flutter/material.dart';
import 'package:move/l10n/app_localizations.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_fonts.dart';
import 'package:move/utils/app_routs.dart';
import 'package:move/widget/custom_bottom.dart';
import 'package:move/widget/custom_text_faild.dart';
import '../../../api/api_service .dart';
import '../../../model/GetProfile.dart';
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
  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  void getProfileData() async {
    try {
      final response = await ApiService().getProfile();
      if (response?.data != null) {
        final user = response!.data!;
        nameController.text = user.name ?? "";
        phoneController.text = user.phone ?? "";

        final avatarId = user.avaterId ?? 8;
        myAvatar = getAvatarFromId(avatarId);
        setState(() {});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: AppColor.red,content: Text(e.toString())),
      );    }
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

  String myAvatar = AppAssets.A8;
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
                      myAvatar = selectedAvatar;
                    });

                },
                child: Container(decoration: BoxDecoration(
                    shape: BoxShape.circle,
                ),
                  child: Image.asset(myAvatar, scale: 0.6),
                ),
              ),
              SizedBox(height: height * 0.04),
              CustomTextField(
                hint: "Name",
                isPassword: false,
                controller: nameController,
                icon: Image.asset(AppAssets.name),
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                hint: "Phone",
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
                onTap: () async {
                  final response = await ApiService().delProfile();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(backgroundColor: AppColor.green,content: Text(response ?? '')),
                  );
                  Navigator.of(context).pushReplacementNamed(AppRouts.loginRouteName);
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
                onTap: () async {
                  final avatarId = getAvatarIdFromAsset(myAvatar);
                  final response = await ApiService().updateProfile(
                    name: nameController.text,
                    phone: phoneController.text,
                    avaterId: avatarId,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(backgroundColor: AppColor.green,content: Text(response
                    )),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
