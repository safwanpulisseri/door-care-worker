import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/widget/toastification_widget.dart';
import '../../../drawer/widget/appbar_widget.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../util/auth_util.dart';
import '../widget/auth_button_widget.dart';
import '../widget/auth_textformfield.dart';
import '../widget/image_container.dart';
import '../widget/loading_dialog.dart';
import '../widget/select_district_widget.dart';
import '../widget/select_service_widget.dart';
import 'sign_in_page.dart';
import 'verify_worker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _districtController.dispose();
    _serviceController.dispose();
    _experienceController.dispose();
  }

  File? profileImage;
  File? idCardImage;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          log("loading...");
          LoadingDialog.show(context);
        }
        if (state is AuthSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const VerifyWorkerPage()),
            (route) => false,
          );
          ToastificationWidget.show(
            context: context,
            type: ToastificationType.success,
            title: 'Success',
            description: 'Successfully signed in!',
            // backgroundColor: AppColor.toneEight,
            textColor: AppColor.secondary,
          );
        } else if (state is AuthFailState) {
          Navigator.pop(context);
          ToastificationWidget.show(
            context: context,
            type: ToastificationType.error,
            title: 'Error',
            description: 'Failed to sign in. Please try again.',
            // backgroundColor: AppColor.toneSeven,
            textColor: AppColor.secondary,
          );
        }
      },
      child: Scaffold(
        appBar: const AppBarSingle(),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.secondary,
                          fontSize: 35,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  AuthTextFormField(
                    controller: _nameController,
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    validator: AuthUtil.validateName,
                  ),
                  AuthTextFormField(
                    controller: _mobileController,
                    textInputType: TextInputType.number,
                    labelText: 'Mobile Number',
                    hintText: 'Enter your mobile number',
                    validator: AuthUtil.validateMobileNumber,
                  ),
                  AuthTextFormField(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    validator: AuthUtil.validateEmail,
                  ),
                  SelectDistrictField(
                    districtController: _districtController,
                  ),
                  SelectServiceField(
                    serviceController: _serviceController,
                  ),
                  AuthTextFormField(
                    controller: _experienceController,
                    textInputType: TextInputType.number,
                    labelText: 'Experience',
                    hintText: 'Enter your experience',
                    validator: AuthUtil.validateExperience,
                  ),
                  AuthTextFormField(
                    controller: _passwordController,
                    textInputType: TextInputType.visiblePassword,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                    validator: AuthUtil.validatePassword,
                    showPasswordToggle: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ImageContainerWidget(
                    onProfileImageSelected: (file) {
                      setState(() {
                        profileImage = file;
                      });
                    },
                    onIdCardImageSelected: (file) {
                      setState(
                        () {
                          idCardImage = file;
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthButton(
                    buttonText: 'Sign Up',
                    buttonCallback: () async {
                      if (_formKey.currentState!.validate()) {
                        // Dismiss the keyboard
                        FocusManager.instance.primaryFocus?.unfocus();

                        // Check if images are valid
                        if (AuthUtil.validateImage(profileImage) != null ||
                            AuthUtil.validateImage(idCardImage) != null) {
                          ToastificationWidget.show(
                            context: context,
                            type: ToastificationType.error,
                            title: 'Validation Error',
                            description: AuthUtil.validateImage(profileImage) ??
                                AuthUtil.validateImage(idCardImage)!,
                            textColor: AppColor.secondary,
                          );
                          return;
                        }

                        // Upload profile image and get its URL
                        String? profileImageUrl = await _uploadImageToFirebase(
                          profileImage!,
                        );

                        // Upload ID card image and get its URL
                        String? idCardImageUrl = await _uploadImageToFirebase(
                          idCardImage!,
                        );

                        if (profileImage == null || idCardImage == null) {
                          ToastificationWidget.show(
                            context: context,
                            type: ToastificationType.error,
                            title: 'Upload Error',
                            description:
                                'Failed to upload images. Please try again.',
                            textColor: AppColor.secondary,
                          );
                          return;
                        }

                        // Trigger sign-up event
                        context.read<AuthBloc>().add(
                              AccountCreateAuthEvent(
                                name: _nameController.text.trim(),
                                mobile: _mobileController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                experience: int.tryParse(
                                        _experienceController.text.trim()) ??
                                    0,
                                district: _districtController.text.trim(),
                                service: _serviceController.text.trim(),
                                idCardImage: idCardImageUrl!,
                                profileImage: profileImageUrl!,
                              ),
                            );
                      } else {
                        ToastificationWidget.show(
                          context: context,
                          type: ToastificationType.error,
                          title: 'Validation Error',
                          description: 'Please correct the errors in the form.',
                          //  backgroundColor: AppColor.toneSeven,
                          textColor: AppColor.secondary,
                        );
                      }
                    },
                    textCallback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (ctx) => const SignInPage()),
                      );
                    },
                    navigationTitle: "Already have an Account? ",
                    navigationSubtitle: "Sign in",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> _uploadImageToFirebase(File image) async {
    try {
      Reference reference = FirebaseStorage.instance.ref().child(
            "images/${DateTime.now().millisecondsSinceEpoch}.png",
          );
      await reference.putFile(image).whenComplete(
        () {
          ToastificationWidget.show(
            context: context,
            type: ToastificationType.success,
            title: 'Success',
            description: 'Image Uploaded succesfully into firebase',
            // backgroundColor: AppColor.toneEight,
            textColor: AppColor.secondary,
          );
        },
      );
      return await reference.getDownloadURL();
    } catch (e) {
      ToastificationWidget.show(
        context: context,
        type: ToastificationType.error,
        title: 'Error',
        description: 'Failed to Upload Image into Firebase',
        textColor: AppColor.secondary,
      );
      return null; // Return null in case of an error
    }
  }
}
