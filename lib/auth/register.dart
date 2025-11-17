import 'package:flutter/material.dart';
import 'package:move/api/api_service%20.dart';
import 'package:move/auth/login.dart';
import 'package:move/l10n/app_localizations.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';
import 'package:move/widget/custom_bottom.dart';
import 'package:move/widget/custom_text_faild.dart';
import '../utils/app_routs.dart';
import '../widget/alert_dialog_utils.dart';
import '../widget/switch.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final List<String> images = [
    AppAssets.A1,
    AppAssets.A2,
    AppAssets.A3,
    AppAssets.A4,
    AppAssets.A5,
    AppAssets.A6,
    AppAssets.A7,
    AppAssets.A8,
    AppAssets.A9,
  ];

  int currentIndex = 0;
  int? selectedIndex;

  late PageController _pageController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController repassController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.33);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
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
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 190,
                  child: PageView.builder(
                    controller: _pageController,
                    physics: selectedIndex != null
                        ? NeverScrollableScrollPhysics()
                        : BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      double scale = currentIndex == index ? 1.8 : 0.9;

                      if (selectedIndex != null && selectedIndex != index) {
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
                                  if (selectedIndex == index) {
                                    selectedIndex = null;
                                  } else {
                                    selectedIndex = index;
                                  }
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                margin:
                                EdgeInsets.symmetric(horizontal: 12),
                                child: Image.asset(images[index]),
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
                  controller: nameController,
                  icon: ImageIcon(
                      AssetImage(AppAssets.name), color: AppColor.whait),
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
                  controller: emailController,
                  icon: ImageIcon(
                      AssetImage(AppAssets.email), color: AppColor.whait),
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
                  controller: passController,
                  icon: ImageIcon(
                      AssetImage(AppAssets.pas), color: AppColor.whait),
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
                  controller: repassController,
                  icon: ImageIcon(
                      AssetImage(AppAssets.pas), color: AppColor.whait),
                  validator:(text) {
                    if (text==null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterPassword;
                    }
                    if (repassController.text!=passController.text) {
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
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  icon: ImageIcon(
                      AssetImage(AppAssets.phone), color: AppColor.whait),
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
                  onTap: register,
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
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      if (selectedIndex == null) {
        AlertDialogUtils.showMessage(
          context: context,
          msg: "Please select an avatar",
          title: "error",
        );
        return;
      }
      String phone = phoneController.text.trim();
      if (!phone.startsWith('+')) {
        phone = '+2$phone';
      }

      AlertDialogUtils.showLoading(context: context, msg: "loading..");
      try {
        final response = await ApiService().register(
          name: nameController.text,
          email: emailController.text,
          password: passController.text,
          phone: phone,
          avatarId: selectedIndex! + 1,
        );

        AlertDialogUtils.hideLoading(context: context);

        if (response.message == 'User created successfully') {
          AlertDialogUtils.showMessage(
            context: context,
            msg: response.message!,
            title: "success",
            pos: "Ok",
            posAction: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouts.updateProfileRouteName,
                    (route) => false,
              );
            },
            nav: "Dismiss",
            navAction: () {
              Navigator.pop(context);
            },
          );
        } else {
          AlertDialogUtils.showMessage(
            context: context,
            msg: response.message!,
            title: "error",
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
}
