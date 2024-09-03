import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/theme/color/app_color.dart';
import '../../../../../core/util/jason_asset.dart';
import '../../../../navigation_menu/view/page/navigation_menu.dart';
import '../../../../onboarding/view/widget/cutom_elevated_button.dart';

class BillGeneratedSuccessPage extends StatelessWidget {
  const BillGeneratedSuccessPage({super.key});

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
              // repeat: false, // Ensure the animation plays only once
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            "Thank you for your service.",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.secondary,
                  fontSize: 27,
                ),
            textAlign: TextAlign.center,
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            "Please verify the amount received from the client.",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColor.secondary,
                  fontSize: 16,
                ),
            textAlign: TextAlign.center,
          ),
          const Spacer(
            flex: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const NavigationMenu(),
                  ),
                );
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
