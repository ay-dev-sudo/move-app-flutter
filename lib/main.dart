import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:move/l10n/app_localizations.dart';
import 'package:move/auth/forget.dart';
import 'package:move/auth/login.dart';
import 'package:move/auth/register.dart';
import 'package:move/onbordscreen.dart';
import 'package:move/onbord1.dart';
import 'package:move/provider/languaged_provider.dart';
import 'package:move/tabs/profile/update_profile/reset_password/reset_password.dart';
import 'package:move/tabs/profile/update_profile/update_profile.dart';
import 'package:move/utils/app_routs.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,


      locale: Locale(languageProvider.appLanguage),


      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,


      initialRoute: AppRouts.onbord1RouteName,


      routes: {
        AppRouts.onbord1RouteName: (context) => const Onbord1(),
        AppRouts.onboardingRouteName: (context) => const OnboardingScreen(),
        AppRouts.loginRouteName: (context) =>  Login(),
        AppRouts.registerRouteName: (context) => const Register(),
        AppRouts.forgetRouteName: (context) => const Forget(),
        AppRouts.updateProfileRouteName: (context) => const UpdateProfile(),
        AppRouts.resetPasswordRouteName: (context) =>  ResetPassword(),

      },
    );
  }
}
