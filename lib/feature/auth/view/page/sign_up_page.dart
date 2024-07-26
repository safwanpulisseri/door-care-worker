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
import '../widget/auth_textformfield_widget.dart';
import '../widget/image_container_widget.dart';
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
        } else if (state is AuthRegistrationSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const VerifyWorkerPage(),
            ),
            (route) => false,
          );
          ToastificationWidget.show(
            context: context,
            type: ToastificationType.success,
            title: 'Success',
            description: 'Successfully signed up!',
            textColor: AppColor.secondary,
          );
        } else if (state is AuthFailState) {
          Navigator.pop(context);
          ToastificationWidget.show(
            context: context,
            type: ToastificationType.error,
            title: 'Error',
            description: 'Failed to sign up. Please try again.',
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
                  SelectDistrictField(districtController: _districtController),
                  SelectServiceField(serviceController: _serviceController),
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
                  const SizedBox(height: 20),
                  ImageContainerWidget(
                    onProfileImageSelected: (file) {
                      setState(() {
                        profileImage = file;
                      });
                    },
                    onIdCardImageSelected: (file) {
                      setState(() {
                        idCardImage = file;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  AuthButton(
                    buttonText: 'Sign Up',
                    buttonCallback: () async {
                      if (_formKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();

                        String? profileImageValidationError =
                            AuthUtil.validateImage(profileImage);
                        String? idCardImageValidationError =
                            AuthUtil.validateImage(idCardImage);

                        if (profileImageValidationError != null ||
                            idCardImageValidationError != null) {
                          ToastificationWidget.show(
                            context: context,
                            type: ToastificationType.error,
                            title: 'Validation Error',
                            description: profileImageValidationError ??
                                idCardImageValidationError!,
                            textColor: AppColor.secondary,
                          );
                          return;
                        }

                        String? profileImageUrl;
                        if (profileImage != null) {
                          profileImageUrl =
                              await _uploadImageToFirebase(profileImage!);
                        }

                        String? idCardImageUrl;
                        if (idCardImage != null) {
                          idCardImageUrl =
                              await _uploadImageToFirebase(idCardImage!);
                        }

                        if (profileImageUrl == null || idCardImageUrl == null) {
                          ToastificationWidget.show(
                            context: context,
                            type: ToastificationType.error,
                            title: 'Upload Error',
                            description:
                                'Failed to upload one or more images. Please try again.',
                            textColor: AppColor.secondary,
                          );
                          return;
                        }

                        context.read<AuthBloc>().add(
                              AccountCreateAuthEvent(
                                name: _nameController.text,
                                mobile: _mobileController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                experience:
                                    num.tryParse(_experienceController.text) ??
                                        0,
                                district: _districtController.text,
                                service: _serviceController.text,
                                idCardImage: idCardImageUrl,
                                profileImage: profileImageUrl,
                              ),
                            );
                      }
                    },
                    textCallback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const SignInPage(),
                        ),
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
      await reference.putFile(image);
      return await reference.getDownloadURL();
    } catch (e) {
      ToastificationWidget.show(
        context: context,
        type: ToastificationType.error,
        title: 'Error',
        description: 'Failed to Upload Image into Firebase',
        textColor: AppColor.secondary,
      );
      return null;
    }
  }
}
