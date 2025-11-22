import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:move/api/api_service%20.dart';
import 'package:move/auth/forget.dart';
import 'package:move/auth/register.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';
import 'package:move/utils/app_routs.dart';
import 'package:move/widget/custom_bottom.dart';
import 'package:move/widget/custom_text_faild.dart';
import 'package:move/widget/switch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations.dart';
import '../widget/alert_dialog_utils.dart';

class Login extends StatefulWidget {
   Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState>formkey = GlobalKey<FormState>();


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
                  validator: (email) {
                    if (email == null || email
                        .trim()
                        .isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterEmail;
                    }
                    final bool emailValid =
                    RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(email);
                    if (!emailValid) {
                      return AppLocalizations.of(context)!.pleaseEnterValidEmail;
                    }
                    return null;
                  },
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
                validator:(text) {
                  if (text==null || text.trim().isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterPassword;
                  }
                  if (text.length<6) {
                    return AppLocalizations.of(context)!.pleaseEnterAtLeast8Char;
                  }
                  return null;
                },
              ),

              SizedBox(height: height * 0.01),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (c) => Forget()));
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    AppLocalizations.of(context)!.forgetPassword,
                    style: AppFonts.regular14yellow,
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),

              CustomButton(
                  onTap:login ,
                  text: AppLocalizations.of(context)!.login,
                  color: AppColor.yellow,
                  borderColor: AppColor.yellow,
                  width: width * 0.93,
                  height: height * 0.06,
                  textFont: AppFonts.inter20black,
                ),


              SizedBox(height: height * 0.01),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.dontHaveAccount,
                      style: AppFonts.regular14white),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => Register()));
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
                  Text(AppLocalizations.of(context)!.or,
                      style: AppFonts.regular14yellow),

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

              CustomButton(text: AppLocalizations.of(context)!.loginWithGoogle,
               onTap: () {
                 loginWithGoogle(context);
               },
                color: AppColor.yellow,
                borderColor: AppColor.yellow,
                width: width * 0.93,
                height: height * 0.060,
                textFont: AppFonts.inter16black,
                icon: ImageIcon(AssetImage(AppAssets.google)),),
              SizedBox(height: height * 0.02),
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

  login() async {
    if (formkey.currentState?.validate() == true) {
      try {
        AlertDialogUtils.showLoading(context: context, msg: "loading...");

        final response = await ApiService().login(
          email: emailController.text,
          password: passwordController.text,
        );

        AlertDialogUtils.hideLoading(context: context);

        final message = response.message ?? "";
        final token = response.data ?? "";

        if (message == "Success Login") {

          if (token.isNotEmpty) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString("token", token);
            print("Token saved successfully: $token");
          }

          AlertDialogUtils.showMessage(
            context: context,
            msg: message,
            title: "success",
            pos: "Ok",
            posAction: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouts.homeScreenRouteName,
                    (route) => false,
              );
            },
          );
        }

      } catch (e) {
        AlertDialogUtils.hideLoading(context: context);
        AlertDialogUtils.showMessage(
          context: context,
          msg: e.toString(),
          title: "error",
        );
      }
    }
  }
  loginWithGoogle(BuildContext context) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("success login with google"),
            backgroundColor: Colors.green,
          ),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login canceled"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
