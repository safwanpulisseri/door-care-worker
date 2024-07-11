import 'package:door_care_worker/view/feature/auth/page/sign_up_page.dart';
import 'package:door_care_worker/view/feature/navigation_menu/page/home_navigation_menu.dart';
import 'package:door_care_worker/view/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'view/feature/onboarding/page/splash_page.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const SplashPage(),
    );
  }
}
