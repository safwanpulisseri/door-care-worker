import 'package:door_care_worker/view/feature/auth/page/sign_in_page.dart';
import 'package:door_care_worker/view/feature/auth/page/sign_up_page.dart';
import 'package:door_care_worker/view/feature/auth/page/verify_worker.dart';
import 'package:door_care_worker/view/feature/onboarding/page/splash_page.dart';
import 'package:door_care_worker/view/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: SplashPage(),
    );
  }
}
