import 'package:doorcareworker/core/widget/padding_widget.dart';
import 'package:doorcareworker/feature/auth/view/widget/auth_textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/png_asset.dart';
import '../../../../core/widget/opacity_container.dart';
import '../../../auth/bloc/auth_bloc/auth_bloc.dart';
import '../widget/appbar_widget.dart';

class UserDetailsPage extends StatelessWidget {
  UserDetailsPage({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarSingle(),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccessState) {
            final user = state.userModel;
            // Initialize controllers with user data
            _nameController.text = user.name;
            _mobileNumberController.text = user.mobile;
            _emailController.text = user.email;
            _experienceController.text = user.experience.toString();
            _serviceNameController.text = user.service;
            _districtController.text = user.district;
            return PaddingWidget(
              child: Column(
                children: [
                  Row(
                    children: [
                      const OpacityContainer(),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Profile',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: AppColor.secondary,
                                  fontSize: 30,
                                ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      // ElevatedButton.icon(
                      //   onPressed: () {},
                      //   label: const Text('SAVE'),
                      //   icon: const FaIcon(FontAwesomeIcons.pen,
                      //       color: AppColor.primary),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: AppColor.background,
                      //     foregroundColor: AppColor.primary,
                      //     padding:
                      //         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      //   ),
                      // ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColor.toneEleven,
                    backgroundImage: user.profileImage.isNotEmpty
                        ? NetworkImage(
                            user.profileImage,
                          )
                        : const AssetImage(
                            AppPngPath.personImage,
                          ),
                  ),
                  AuthTextFormField(
                    controller: _nameController,
                    labelText: 'Name',
                    hintText: 'Update your name',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthTextFormField(
                    controller: _mobileNumberController,
                    labelText: 'Mobile Number',
                    hintText: 'Update your number',
                  ),
                  AuthTextFormField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'Update your email',
                  ),
                  AuthTextFormField(
                    controller: _experienceController,
                    labelText: 'Experience',
                    hintText: 'Update your experience',
                  ),
                  AuthTextFormField(
                    controller: _serviceNameController,
                    labelText: 'Service',
                    hintText: 'Update your service',
                  ),
                  AuthTextFormField(
                    controller: _districtController,
                    labelText: 'District',
                    hintText: 'Update your district',
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'Failed to Fetch Your Details',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColor.background,
                      fontSize: 17,
                    ),
              ),
            );
          }
        },
      ),
    );
  }
}
