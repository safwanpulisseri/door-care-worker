// import 'dart:io';
// import 'package:flutter/material.dart';
// import '../../../../core/theme/color/app_color.dart';
// import '../../data/repository/auth_repo.dart';
// import '../../data/service/remote/auth_remote_service.dart';
// import '../page/sign_in_page.dart';
// import '../util/auth_util.dart';
// import '../widget/auth_button_widget.dart';
// import '../widget/auth_textformfield.dart';
// import '../widget/image_container.dart';
// import '../widget/select_district_widget.dart';
// import '../widget/select_service_widget.dart';

// class SignUpForm extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//   final TextEditingController nameController;
//   final TextEditingController mobileController;
//   final TextEditingController emailController;
//   final TextEditingController passwordController;
//   final TextEditingController districtController;
//   final TextEditingController serviceController;
//   final TextEditingController experienceController;
//   final File? profileImage;
//   final File? idCardImage;
//   final Function(File) onProfileImageSelected;
//   final Function(File) onIdCardImageSelected;
//   final VoidCallback onSignUp;

//   const SignUpForm({
//     required this.formKey,
//     required this.nameController,
//     required this.mobileController,
//     required this.emailController,
//     required this.passwordController,
//     required this.districtController,
//     required this.serviceController,
//     required this.experienceController,
//     required this.profileImage,
//     required this.idCardImage,
//     required this.onProfileImageSelected,
//     required this.onIdCardImageSelected,
//     required this.onSignUp,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: ListView(
//           children: [
//             Text(
//               'Sign Up',
//               style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: AppColor.secondary,
//                     fontSize: 35,
//                   ),
//               textAlign: TextAlign.center,
//             ),
//             AuthTextFormField(
//               controller: nameController,
//               labelText: 'Name',
//               hintText: 'Enter your name',
//               validator: AuthUtil.validateName,
//             ),
//             AuthTextFormField(
//               controller: mobileController,
//               textInputType: TextInputType.number,
//               labelText: 'Mobile Number',
//               hintText: 'Enter your mobile number',
//               validator: AuthUtil.validateMobileNumber,
//             ),
//             AuthTextFormField(
//               controller: emailController,
//               textInputType: TextInputType.emailAddress,
//               labelText: 'Email',
//               hintText: 'Enter your email',
//               validator: AuthUtil.validateEmail,
//             ),
//             SelectDistrictField(
//               districtController: districtController,
//             ),
//             SelectServiceField(
//               serviceController: serviceController,
//             ),
//             AuthTextFormField(
//               controller: experienceController,
//               textInputType: TextInputType.number,
//               labelText: 'Experience',
//               hintText: 'Enter your experience',
//               validator: AuthUtil.validateExperience,
//             ),
//             AuthTextFormField(
//               controller: passwordController,
//               textInputType: TextInputType.visiblePassword,
//               labelText: 'Password',
//               hintText: 'Enter your password',
//               obscureText: true,
//               validator: AuthUtil.validatePassword,
//               showPasswordToggle: true,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ImageContainerWidget(
//               onProfileImageSelected: onProfileImageSelected,
//               onIdCardImageSelected: onIdCardImageSelected,
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             AuthButton(
//               buttonText: 'Sign Up',
//               buttonCallback: () {
//                 onSignUp;
//               },
//               textCallback: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (ctx) => const SignInPage()),
//                 );
//               },
//               navigationTitle: "Already have an Account? ",
//               navigationSubtitle: "Sign in",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
