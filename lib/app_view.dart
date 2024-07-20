import 'package:doorcareworker/core/theme/app_theme.dart';
import 'package:doorcareworker/feature/auth/view/page/sign_in_page.dart';
import 'package:doorcareworker/feature/navigation_menu/view/page/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'feature/auth/view/page/sign_up_page.dart';
import 'feature/onboarding/view/page/splash_page.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const SplashPage(),
      ),
    );
  }
}
