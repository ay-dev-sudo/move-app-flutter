import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:move/auth/forget.dart';
import 'package:move/auth/register.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';
import 'package:move/utils/app_routs.dart';
import 'package:move/widget/custom_bottom.dart';
import 'package:move/widget/custom_text_faild.dart';
import 'package:move/widget/switch.dart';

import '../l10n/app_localizations.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
     final GlobalKey<FormState>formkey=GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.08),
              Image.asset(AppAssets.log),
          
              SizedBox(height: height * 0.08),
          
              CustomTextField(
                hint: AppLocalizations.of(context)!.email,
                isPassword: false,
                controller: emailController,
                icon: ImageIcon(
                  AssetImage(AppAssets.email),
                  color: AppColor.whait,
                ),
              ),
          
              SizedBox(height: height * 0.026),
          
              CustomTextField(
                hint: AppLocalizations.of(context)!.password,
                isPassword: true,
                controller: passwordController,
                icon: ImageIcon(
                  AssetImage(AppAssets.pas),
                  color: AppColor.whait,
                ),
              ),
          
              SizedBox(height: height * 0.01),
          
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>Forget()));
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    AppLocalizations.of(context)!.forgetPassword,
                    style: AppFonts.regular14yellow,
                  ),
                ),
              ),
          
              SizedBox(height: height * 0.02),
          
              InkWell(
                onTap: (){
                  Navigator.of(context).pushReplacementNamed(AppRouts.updateProfileRouteName);
              if(formkey.currentState!.validate()){
              print("Success login");
}
                },
                child: CustomButton(
                  text:AppLocalizations.of(context)!.login,
                  color: AppColor.yellow,
                  borderColor: AppColor.yellow,
                  width: width * 0.93,
                  height: height * 0.06,
                  textFont: AppFonts.inter20black,
                ),
              ),
          
              SizedBox(height: height * 0.01),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.dontHaveAccount, style: AppFonts.regular14white),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>Register()));
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                     AppLocalizations.of(context)!.createOne,
                      style: AppFonts.regular14yellow
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: height * 0.017),
          
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColor.yellow,
                      thickness: 1,
                      indent: width * 0.18,
                      endIndent: 17,
                    ),
                  ),
                  Text(AppLocalizations.of(context)!.or, style: AppFonts.regular14yellow),
          
                  Expanded(
                    child: Divider(
                      color: AppColor.yellow,
                      thickness: 1,
                      indent: 17,
                      endIndent: width * 0.18,
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: height * 0.035),
              
              CustomButton(text: AppLocalizations.of(context)!.loginWithGoogle, color: AppColor.yellow, borderColor: AppColor.yellow, width: width*0.93, height: height*0.060, textFont: AppFonts.inter16black,icon: ImageIcon(AssetImage(AppAssets.google)),),
              SizedBox(height: height*0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSwitch(),
          
          
                ],
              ),
          
          
            ],
          ),
        ),
      ),
    );
  }
}
