import 'package:flutter/material.dart';
import 'view/page/about_us_page.dart';
import 'view/page/how_to_use_page.dart';
import 'view/page/booking_history_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:toastification/toastification.dart';
import '../../core/widget/toastification_widget.dart';
import 'package:doorcareworker/core/util/png_asset.dart';
import 'package:doorcareworker/core/util/redirect_link.dart';
import 'package:doorcareworker/core/theme/color/app_color.dart';
import 'package:doorcareworker/feature/auth/view/page/sign_in_page.dart';
import 'package:doorcareworker/feature/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:doorcareworker/feature/drawer/view/page/user_details_page.dart';
import 'package:doorcareworker/feature/drawer/view/page/wallet_amount_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.primary,
      child: Column(
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccessState) {
                final user = state.userModel;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx) => UserDetailsPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70, left: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColor.background,
                          backgroundImage: user.profileImage.isNotEmpty
                              ? NetworkImage(user.profileImage)
                              : const AssetImage(AppPngPath.personImage),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                    color: AppColor.background,
                                    fontSize: 17,
                                  ),
                            ),
                            Text(
                              user.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColor.background,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Text(
                  'Failed to Fetch Your Details',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppColor.background,
                        fontSize: 17,
                      ),
                );
              }
            },
          ),
          Expanded(
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                String userEmail = '';
                if (state is AuthSuccessState) {
                  userEmail = state.userModel.email;
                }
                return ListView(
                  children: [
                    DrawerItem(
                      icon: IconlyLight.wallet,
                      text: 'Wallet',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WalletPage(email: userEmail),
                          ),
                        );
                      },
                    ),
                    DrawerItem(
                      icon: IconlyLight.bookmark,
                      text: 'History',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingHistoryPage(),
                          ),
                        );
                      },
                    ),
                    DrawerItem(
                      icon: IconlyLight.activity,
                      text: 'How to use',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HowToUsePage(),
                          ),
                        );
                      },
                    ),

                    // DrawerItem(
                    //   icon: Icons.notifications,
                    //   text: 'Notification',
                    //   onTap: () {},
                    // ),
                    DrawerItem(
                      icon: IconlyLight.paper,
                      text: 'Privacy Policy',
                      onTap: () async {
                        await RedirectLink.launchPrivacyPolicy();
                      },
                    ),
                    DrawerItem(
                      icon: IconlyLight.message,
                      text: 'Terms & Conditions',
                      onTap: () async {
                        await RedirectLink.launchPrivacyPolicy();
                      },
                    ),
                    DrawerItem(
                      icon: IconlyLight.infoSquare,
                      text: 'About us',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutUsPage(),
                          ),
                        );
                      },
                    ),
                    // DrawerItem(
                    //   icon: Icons.share,
                    //   text: 'Share App',
                    //   onTap: () {},
                    // ),
                    DrawerItem(
                      icon: IconlyLight.logout,
                      text: 'Log Out',
                      onTap: () {
                        context.read<AuthBloc>().add(SignOutEvent());
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ),
                          (route) => false,
                        );
                        ToastificationWidget.show(
                          context: context,
                          type: ToastificationType.success,
                          title: 'Success',
                          description: 'You have been signed out successfully.',
                          textColor: AppColor.secondary,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.textfield.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            height: 40,
            width: 250,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(IconlyLight.infoSquare, color: AppColor.background),
                SizedBox(width: 10),
                Text('Pulisseri Production',
                    style: TextStyle(color: AppColor.background)),
              ],
            ),
          ),
          const SizedBox(height: 5),
          const Divider(
            thickness: 0.5,
            indent: 30,
            endIndent: 30,
          ),
          Text(
            'version: 1.0.0+1',
            style: TextStyle(
              color: AppColor.toneThree,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColor.background),
      title: Text(
        text,
        style: const TextStyle(color: AppColor.background),
      ),
      onTap: onTap,
    );
  }
}
