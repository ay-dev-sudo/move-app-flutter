import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:move/l10n/app_localizations.dart';
import 'package:move/auth/forget.dart';
import 'package:move/auth/login.dart';
import 'package:move/auth/register.dart';
import 'package:move/on_bording_screen/onbordscreen.dart';
import 'package:move/on_bording_screen/onbord1.dart';
import 'package:move/provider/languaged_provider.dart';
import 'package:move/shared_helper/shared_helper.dart';
import 'package:move/tabs/browse/browse_tap.dart';
import 'package:move/tabs/home/movie_details_screen/movie_details_screen.dart';
import 'package:move/tabs/profile/update_profile/reset_password/reset_password.dart';
import 'package:move/tabs/profile/update_profile/update_profile.dart';
import 'package:move/utils/app_routs.dart';
import 'package:provider/provider.dart';

import 'home_screen/home_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  String routeName;
  var token =await SharedHelper.getToken();
    if (token.isEmpty) {
      routeName=AppRouts.onbord1RouteName;
    }
    else{
      routeName=AppRouts.homeScreenRouteName;
    }
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
      ],
      child: MyApp(routeName:routeName ,),
    ),
  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key,required this.routeName});
  String routeName;
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,


      locale: Locale(languageProvider.appLanguage),


      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,


      initialRoute:routeName,


      routes: {
        AppRouts.onbord1RouteName: (context) => const Onbord1(),
        AppRouts.onboardingRouteName: (context) => const OnboardingScreen(),
        AppRouts.loginRouteName: (context) =>  Login(),
        AppRouts.registerRouteName: (context) => const Register(),
        AppRouts.forgetRouteName: (context) => const Forget(),
        AppRouts.updateProfileRouteName: (context) =>  UpdateProfileScreen(),
        AppRouts.resetPasswordRouteName: (context) =>  ResetPassword(),
        AppRouts.homeScreenRouteName: (context) =>  HomeScreen(),
        AppRouts.movieDetailsScreenRouteName: (context) =>  MovieDetailsScreen(),
        AppRouts.browseTapScreenRouteName: (context) =>  BrowseTap(),

      },
    );
  }
}
