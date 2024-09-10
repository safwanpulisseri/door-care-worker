import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/widget/opacity_container.dart';
import '../../../auth/bloc/auth_bloc/auth_bloc.dart';
import '../../../auth/data/service/local/auth_local_service.dart';
import '../widget/appbar_widget.dart';

class WalletPage extends StatelessWidget {
  final String email;

  const WalletPage({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    // Retrieve password from secure storage and dispatch the event
    return FutureBuilder<String?>(
      future: _retrievePassword(context), // Custom method to retrieve password
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || snapshot.data == null) {
          return const Center(child: Text('Error loading password'));
        }

        final password = snapshot.data!;

        // Dispatch the event with email and password
        context.read<AuthBloc>().add(EmailSignInAuthEvent(
              email: email,
              password: password,
            ));

        // Listen to state changes and update UI accordingly
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AuthFailState) {
              return const Center(child: Text('Authentication failed.'));
            } else if (state is AuthSuccessState) {
              final user = state.userModel;

              return Scaffold(
                backgroundColor: AppColor.background,
                appBar: const AppBarSingle(),
                body: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const OpacityContainer(),
                          const SizedBox(width: 10),
                          Text(
                            'Wallet',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
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
                              // Display user data here
                              Text(
                                '₹ ${user.wallet}', // Assuming wallet balance is available in the user model
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
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text('Unexpected state.'));
            }
          },
        );
      },
    );
  }

  Future<String?> _retrievePassword(BuildContext context) async {
    // Retrieve password using the AuthLocalService
    final authLocalService = context.read<AuthLocalService>();
    return await authLocalService.getPassword();
  }
}
