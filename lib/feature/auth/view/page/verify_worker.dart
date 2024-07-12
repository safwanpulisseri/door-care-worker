import 'package:doorcareworker/feature/auth/view/page/sign_in_page.dart';
import 'package:doorcareworker/core/util/jason_asset.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../onboarding/view/widget/cutom_elevated_button.dart';

class VerifyWorkerPage extends StatelessWidget {
  const VerifyWorkerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: Lottie.asset(
              AppJasonPath.verifyIcon,
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your join request has\nbeen sent successfully.\nPlease wait for further\nupdates.",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondary,
                      fontSize: 27,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Spacer(
            flex: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: CustomElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const SignInPage()));
              },
              text: 'Continue',
            ),
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
