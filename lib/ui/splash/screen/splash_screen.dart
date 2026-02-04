import 'package:evently_c17/ui/home/screen/home_screen.dart';
import 'package:evently_c17/ui/onBoarding/screen/on_boarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/resources/assets_manager.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "splash";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AssetsManager.logo))
          .animate(
        onComplete: (controller){
          if (FirebaseAuth.instance.currentUser != null) {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          } else {
            Navigator.pushReplacementNamed(context, OnBoardingScreen.routeName);
          }
        },
      )
          .slideX(duration: Duration(seconds: 1))
          .then()
          .scale(duration: Duration(seconds: 1), begin: Offset(0.5, 0.5)),
    );
  }
}
