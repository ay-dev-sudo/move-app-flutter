import 'package:flutter/material.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';

class CastContainar extends StatelessWidget {
  const CastContainar({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.silver,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(AppAssets.cast1,),
            SizedBox(width: width * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name: Hayley Atwell",
                  style: AppFonts.regular20white,
                  softWrap: true,
                ),
                SizedBox(height: height*0.01),
                Text(
                  "Character: Captain ",
                  style: AppFonts.regular20white,
                  maxLines: 5,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
