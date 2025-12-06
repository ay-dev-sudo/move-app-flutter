import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/api/api_service%20.dart';
import 'package:move/auth/login.dart';
import 'package:move/auth/register_cubit/register_view_model.dart';
import 'package:move/l10n/app_localizations.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';
import 'package:move/widget/custom_bottom.dart';
import 'package:move/widget/custom_text_faild.dart';
import '../utils/app_routs.dart';
import '../widget/alert_dialog_utils.dart';
import '../widget/switch.dart';
import 'auth_states.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  late PageController _pageController;




  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.33);
  }
  RegisterViewModel viewModel = RegisterViewModel();


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocListener<RegisterViewModel, AuthStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is AuthLoadingState) {
          AlertDialogUtils.showLoading(context: context, msg: "loading...");
        }
        else if (state is AuthErrorState) {
          AlertDialogUtils.hideLoading(context: context);
          AlertDialogUtils.showMessage(
              context: context,
              msg: state.errorMessage,
              title: "Error",
              pos: "Ok",
              posAction: () {
                Navigator.pop(context);
              }
          );
        }
        else if (state is AuthSuccessState) {
          AlertDialogUtils.hideLoading(context: context);
          AlertDialogUtils.showMessage(
            context: context,
            msg: state.message,
            title: "Success",
            pos: "Ok",
            posAction: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouts.loginRouteName,
                    (route) => false,
              );
            },
          );
        }
        else if (state is AvatarErrorState) {
          AlertDialogUtils.hideLoading(context: context);
          AlertDialogUtils.showMessage(
            context: context,
            msg: state.errorMessage,
            title: "Error",
            pos: "Ok",
            posAction: () {
              Navigator.of(context).pop();
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.black,
        appBar: AppBar(
          toolbarHeight: 30,
          title: Text(AppLocalizations.of(context)!.register,
              style: AppFonts.regular20yellow),
          centerTitle: true,
          backgroundColor: AppColor.black,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: AppColor.yellow),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 190,
                    child: PageView.builder(
                      controller: _pageController,
                      physics: viewModel.selectedIndex != null
                          ? NeverScrollableScrollPhysics()
                          : BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: viewModel.images.length,
                      onPageChanged: (index) {
                        setState(() {
                          viewModel.currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        double scale = viewModel.currentIndex == index ? 1.8 : 0.9;

                        if (viewModel.selectedIndex != null && viewModel.selectedIndex != index) {
                          return const SizedBox.shrink();
                        }

                        return TweenAnimationBuilder(
                          tween: Tween<double>(begin: scale, end: scale),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (viewModel.selectedIndex == index) {
                                        viewModel.selectedIndex = null;
                                        viewModel.avatarIndex = null;
                                      } else {
                                        viewModel.selectedIndex = index;
                                        viewModel.avatarIndex = index + 1;
                                      }
                                    });
                                  },
                                  child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  margin:
                                  EdgeInsets.symmetric(horizontal: 12),
                                  child: Image.asset(viewModel.images[index]),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hint: AppLocalizations.of(context)!.name,
                    isPassword: false,
                    controller: viewModel.nameCtrl,
                    icon: ImageIcon(
                        AssetImage(AppAssets.name), color: AppColor.white),
                    validator:(name) {
                      if (name==null || name.trim().isEmpty) {
                        return AppLocalizations.of(context)!.pleaseEnterName;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  CustomTextField(
                    hint: AppLocalizations.of(context)!.email,
                    isPassword: false,
                    controller: viewModel.emailCtrl,
                    icon: ImageIcon(
                        AssetImage(AppAssets.email), color: AppColor.white),
                    validator:(email) {
                      if (email==null || email.trim().isEmpty) {
                        return AppLocalizations.of(context)!.pleaseEnterEmail;
                      }
                      final bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email);
                      if (!emailValid) {
                        return AppLocalizations.of(context)!.pleaseEnterValidEmail;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  CustomTextField(
                    hint: AppLocalizations.of(context)!.password,
                    isPassword: true,
                    controller: viewModel.passwordCtrl,
                    icon: ImageIcon(
                        AssetImage(AppAssets.pas), color: AppColor.white),
                    validator:(text) {
                      if (text==null || text.trim().isEmpty) {
                        return AppLocalizations.of(context)!.pleaseEnterPassword;
                      }
                      if (text.length<8) {
                        return AppLocalizations.of(context)!.pleaseEnterAtLeast8Char;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  CustomTextField(
                    hint: AppLocalizations.of(context)!.confirmPassword,
                    isPassword: true,
                    controller: viewModel.confirmPasswordCtrl,
                    icon: ImageIcon(
                        AssetImage(AppAssets.pas), color: AppColor.white),
                    validator:(text) {
                      if (text==null || text.trim().isEmpty) {
                        return AppLocalizations.of(context)!.pleaseEnterPassword;
                      }
                      if (viewModel.confirmPasswordCtrl.text!=viewModel.passwordCtrl.text) {
                        return AppLocalizations.of(context)!.rePasswordMustMatch;
                      }
                      if (text.length<8) {
                        return AppLocalizations.of(context)!.pleaseEnterAtLeast8Char;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  CustomTextField(
                    hint: AppLocalizations.of(context)!.phoneNumber,
                    isPassword: false,
                    controller: viewModel.phoneCtrl,
                    keyboardType: TextInputType.number,
                    icon: ImageIcon(
                        AssetImage(AppAssets.phone), color: AppColor.white),
                    validator: (phone) {
                      if (phone == null || phone.trim().isEmpty) {
                        return AppLocalizations.of(context)!.pleaseEnterPhone;
                      }
                      return null;
                    },

                  ),
                  SizedBox(height: 25),
                  CustomButton(
                    text: AppLocalizations.of(context)!.createAccount,
                    color: AppColor.yellow,
                    borderColor: AppColor.yellow,
                    width: width * 0.93,
                    height: height * 0.06,
                    textFont: AppFonts.inter20black,
                    onTap: viewModel.register,
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.alreadyHaveAccount,
                          style: AppFonts.regular14white),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (c) => Login()),
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.login,
                            style: AppFonts.regular14yellow),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
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
        ),
      ),
    );
  }

}
