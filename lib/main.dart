import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c17/core/providers/theme_provider.dart';
import 'package:evently_c17/core/providers/user_provider.dart';
import 'package:evently_c17/core/remote/local/prefs_helper.dart';
import 'package:evently_c17/core/resources/app_theme.dart';
import 'package:evently_c17/firebase_options.dart';
import 'package:evently_c17/ui/add_event/screen/add_event_screen.dart';
import 'package:evently_c17/ui/forget_pass/screen/forgetpas_screen.dart';
import 'package:evently_c17/ui/home/screen/home_screen.dart';
import 'package:evently_c17/ui/onBoarding/screen/on_boarding.dart';
import 'package:evently_c17/ui/signin/screen/signin_screen.dart';
import 'package:evently_c17/ui/signup/screen/signup_screen.dart';
import 'package:evently_c17/ui/splash/screen/splash_screen.dart';
import 'package:evently_c17/ui/start/screen/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await PrefsHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider()..initTheme(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: PrefsHelper.getThemeMode() == ThemeMode.light
          ? AppTheme.lightTheme
          : AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        StartScreen.routeName: (_) => StartScreen(),
        SigninScreen.routeName: (_) => SigninScreen(),
        SignupScreen.routeName: (_) => SignupScreen(),
        ForgetpassScreen.routeName: (_) => ForgetpassScreen(),
        HomeScreen.routeName: (_) => ChangeNotifierProvider(create: (context) => UserProvider(), child: HomeScreen()),
        AddEventScreen.routeName: (_) => AddEventScreen(),
        OnBoardingScreen.routeName: (_) => OnBoardingScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
