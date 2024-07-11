import 'package:door_care_worker/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'feature/onboarding/view/page/splash_page.dart';

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
