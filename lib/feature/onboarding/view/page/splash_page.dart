import 'onboarding_home.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doorcareworker/core/util/svg_asset.dart';
import 'package:doorcareworker/core/theme/color/app_color.dart';
import '../../../navigation_menu/view/page/navigation_menu.dart';
import 'package:doorcareworker/feature/auth/bloc/auth_bloc/auth_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeNavigationMenu(),
            ),
            (route) => false,
          );
        }
        if (state is AuthFailState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const OnboardingScreen(),
              ),
              (route) => false);
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const Spacer(flex: 4),
                SvgPicture.asset(
                  AppSvgPath.splashLogo,
                ),
                const Spacer(
                  flex: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
