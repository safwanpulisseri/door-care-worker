import 'package:doorcareworker/core/theme/color/app_color.dart';
import 'package:doorcareworker/feature/drawer/view/widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/widget/opacity_container.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const AppBarSingle(),
      body: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: Column(children: [
            Row(
              children: [
                const OpacityContainer(),
                const SizedBox(width: 10),
                Text(
                  'Wallet and History',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppColor.secondary,
                        fontSize: 30,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '₹ 5655',
                      style: const TextStyle(
                        color: AppColor.background,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          IconlyLight.wallet,
                          color: AppColor.background,
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          FontAwesomeIcons.wifi,
                          size: 20,
                          color: AppColor.background,
                        ),
                        const Spacer(),
                        Image.asset(
                          'assets/png/app_logo.png', // Replace with your AppPngPath if necessary
                          width: 40,
                          height: 40,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
