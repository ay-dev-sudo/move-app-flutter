import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:move/l10n/app_localizations.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/widget/custom_bottom.dart';
import 'package:move/widget/custom_text_faild.dart';

import '../utils/app_color.dart';
import '../utils/app_fonts.dart';

class Forget extends StatelessWidget {
  const Forget({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        toolbarHeight: 30,
        title: Text(AppLocalizations.of(context)!.forget, style: AppFonts.regular20yellow),
        centerTitle: true,
        backgroundColor: AppColor.black,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColor.yellow),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Image.asset(AppAssets.forget),
        SizedBox(height: height*0.03,),
            CustomTextField(hint:AppLocalizations.of(context)!.email, isPassword: false, controller: emailController, icon: ImageIcon(AssetImage(AppAssets.email),color: AppColor.white,)),
            SizedBox(height: height*0.02,),
            CustomButton(text:AppLocalizations.of(context)!.verifyemail, color:AppColor.yellow, borderColor: AppColor.yellow, width: width*0.93, height: height*0.06, textFont: AppFonts.inter20black)
          ],
        ),
      ),
    );
  }
}
