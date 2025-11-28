import 'package:flutter/material.dart';
import 'package:move/l10n/app_localizations.dart';
import 'package:move/on_bording_screen/onbordscreen.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';
import 'package:move/widget/custom_bottom.dart';

class Onbord2 extends StatelessWidget {
  const Onbord2({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [



            Image.asset(
              AppAssets.on,
              fit: BoxFit.cover,
              height: double.infinity,
            ),



          Padding(
            padding:  EdgeInsets.all(8.0),
            child: Align(

              alignment: Alignment.bottomCenter,

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.discoverMovies,
                      style: AppFonts.mediam36White,
                      textAlign: TextAlign.center,
                    ),
                     SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.exploreVastCollection,
                      style: AppFonts.regular20gray,
                      textAlign: TextAlign.center,
                    ),

            SizedBox(height: height*0.03,),
                    CustomButton(text: AppLocalizations.of(context)!.next, color: AppColor.yellow, borderColor: AppColor.yellow, width: width*0.9,textFont: AppFonts.inter20black, height: height*0.07,onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>OnboardingScreen()));
                    },),
                    SizedBox(height: height*0.04,)
                  ],
                ),
              ),
          ),

        ],
      ),
    );
  }
}
