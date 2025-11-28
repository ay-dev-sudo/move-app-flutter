import 'package:flutter/material.dart';
import 'package:move/on_bording_screen/onbord2.dart';
import 'package:move/on_bording_screen/onbordscreen.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';
import 'package:move/widget/custom_bottom.dart';
import '../../l10n/app_localizations.dart';

class Onbord1 extends StatelessWidget {
  const Onbord1({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [



            Image.asset(
              AppAssets.on1,
              fit: BoxFit.cover,
              height: double.infinity,
            ),



          Align(
            alignment: Alignment.bottomCenter,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.findYourNextFavoriteMovieHere,
                      style: AppFonts.mediam36White,
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.getAccessToHugeLibrary,
                      style: AppFonts.regular20gray,
                      textAlign: TextAlign.center,
                    ),

                SizedBox(height: height*0.03,),
                    CustomButton(text: AppLocalizations.of(context)!.exploreNow, color: AppColor.yellow, borderColor: AppColor.yellow, width: width*0.9,textFont: AppFonts.inter20black, height: height*0.07,onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>Onbord2()));
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
