import '../../../../core/util/redirect_link.dart';
import '../widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import '../../../../core/util/svg_asset.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/widget/opacity_container.dart';
import 'package:doorcareworker/core/widget/padding_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HowToUsePage extends StatelessWidget {
  HowToUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarSingle(),
      body: PaddingWidget(
        child: Column(
          children: [
            // Row at the top
            Row(
              children: [
                const OpacityContainer(),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'How to use',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppColor.secondary,
                        fontSize: 30,
                      ),
                ),
              ],
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppSvgPath.mainLogo,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 250,
                    child: Text(
                      "Here's a quick guide on how to use the app: Enjoy using the app and manage your finances. Please visit our YouTube channel or watch our video now:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await RedirectLink
                          .launchYouTubeVideo(); // Launch YouTube video on tap
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'YouTube video link', // Text to act as a link
                          style: TextStyle(
                            color: AppColor.toneFive,
                            decoration: TextDecoration.underline,
                            fontSize: 22,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(FontAwesomeIcons.link),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
