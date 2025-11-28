import 'package:flutter/material.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';
import 'package:move/widget/custom_bottom.dart';

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String ?description;
  final String text;
  final String text1;
  final VoidCallback? onNext;



  final VoidCallback? onTap;
  final VoidCallback? onTap1;
  final double width;
  final double height;
  final double vertical;
  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
     this.description,
    required this.text,

    required this.width,
    required this.height,
    this.onNext,
    this.onTap, required this.vertical, required this.text1, this.onTap1,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: AppColor.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding:  EdgeInsets.symmetric(vertical:vertical , horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppFonts.regular24white,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            if (description != null && description!.isNotEmpty) ...[

              Text(
                description!,
                style: AppFonts.regular20white,
                textAlign: TextAlign.center,
              ),
            ],
            SizedBox(height: 20),

            CustomButton(
              textFont: AppFonts.inter20black,
              text: text,
              color: AppColor.yellow,
              borderColor: AppColor.yellow,
              width: width,
              height: height,
              onTap: onNext,
            ),
             SizedBox(height: 20),

            CustomButton(
              textFont: AppFonts.regular20yellow,
              text: text1,
              color: Colors.transparent,
              borderColor:AppColor.yellow,
              width: width,
              height: height,
              onTap: onTap1,
            ),
          ],
        ),
      ),
    );
  }
}
