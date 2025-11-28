import 'package:flutter/material.dart';
import 'package:move/auth/login.dart';
import 'package:move/l10n/app_localizations.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_color.dart';
import 'onbord.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return PageView(
      children: [

        OnboardingPage(
          imagePath: AppAssets.on3,
          title: AppLocalizations.of(context)!.exploreAllGenres,
          description:
          AppLocalizations.of(context)!.discoverMoviesEveryGenre,
          text:AppLocalizations.of(context)!.next,
          width: width * 0.93,
          height: height * 0.07,
          vertical: 30,
          text1: AppLocalizations.of(context)!.back,
          onTap1: () {
            Navigator.pop(context);
          },

          onNext: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OnboardingPage(
                  imagePath: AppAssets.on4,
                  title: AppLocalizations.of(context)!.createWatchlists,
                  description:
                  AppLocalizations.of(context)!.saveMoviesToWatchlist,
                  text:AppLocalizations.of(context)!.next,
                  width: width * 0.93,
                  height: height * 0.07,
                  vertical: 30,
                  text1: AppLocalizations.of(context)!.back,
                  onTap1: () {
                    Navigator.pop(context);
                  },

                  onNext: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnboardingPage(
                          imagePath: AppAssets.on5,
                          title: AppLocalizations.of(context)!.rateReviewAndLearn,
                          description:
                          AppLocalizations.of(context)!.shareYourThoughts,
                          text:AppLocalizations.of(context)!.next,
                          width: width * 0.93,
                          height: height * 0.07,
                          vertical: 30,
                          text1: AppLocalizations.of(context)!.back,
                          onTap1: () {
                            Navigator.pop(context);
                          },

                          onNext: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OnboardingPage(
                                  imagePath: AppAssets.on6,

                                  title: AppLocalizations.of(context)!.startWatchingNow
                                  ,

                                  text: AppLocalizations.of(context)!.finish,
                                  width: width * 0.93,
                                  height: height * 0.07,
                                  vertical: 10,
                                  text1: AppLocalizations.of(context)!.back,
                                   onTap1: () {
                              Navigator.pop(context);
                              },

                                  onNext: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (c)=>Login()));
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
