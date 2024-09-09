import 'package:doorcareworker/feature/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:doorcareworker/feature/auth/view/page/sign_in_page.dart';
import 'package:doorcareworker/feature/drawer/view/page/user_details.dart';
import 'package:doorcareworker/feature/drawer/view/page/wallet.dart';
import 'package:doorcareworker/core/theme/color/app_color.dart';
import 'package:doorcareworker/core/util/png_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import '../../core/widget/toastification_widget.dart';

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
                        const SizedBox(width: 5),
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
                      icon: Icons.wallet,
                      text: 'My Wallet',
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
                      icon: Icons.history,
                      text: 'History',
                      onTap: () {},
                    ),
                    DrawerItem(
                      icon: Icons.help_outline,
                      text: 'How to use',
                      onTap: () {},
                    ),
                    DrawerItem(
                      icon: Icons.notifications,
                      text: 'Notification',
                      onTap: () {},
                    ),
                    DrawerItem(
                      icon: Icons.privacy_tip,
                      text: 'Privacy Policy',
                      onTap: () {},
                    ),
                    DrawerItem(
                      icon: Icons.info,
                      text: 'About us',
                      onTap: () {},
                    ),
                    DrawerItem(
                      icon: Icons.support,
                      text: 'Support',
                      onTap: () {},
                    ),
                    DrawerItem(
                      icon: Icons.share,
                      text: 'Share App',
                      onTap: () {},
                    ),
                    DrawerItem(
                      icon: Icons.logout,
                      text: 'Sign Out',
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
              color: AppColor.toneThree.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            height: 40,
            width: 250,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, color: AppColor.background),
                SizedBox(width: 10),
                Text('Pulisseri Production',
                    style: TextStyle(color: AppColor.background)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            thickness: 0.5,
            indent: 30,
            endIndent: 30,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('version number',
                style: TextStyle(color: AppColor.toneThree)),
          ),
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
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
