import 'dart:io';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/list_of_elements.dart';
import '../../../../core/widget/toastification_widget.dart';
import '../../../drawer/widget/appbar_widget.dart';
import '../util/auth_util.dart';
import '../widget/auth_button_widget.dart';
import '../widget/auth_textformfield.dart';
import '../widget/image_container.dart';
import 'sign_in_page.dart';
import 'verify_worker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? profileImage;
  File? idCardImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarSingle(),
      body: SafeArea(
        child: Form(
          key: formKey,
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
                  controller: nameController,
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  validator: AuthUtil.validateName,
                ),
                AuthTextFormField(
                  controller: mobileController,
                  textInputType: TextInputType.number,
                  labelText: 'Mobile Number',
                  hintText: 'Enter your mobile number',
                  validator: AuthUtil.validateMobileNumber,
                ),
                AuthTextFormField(
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  validator: AuthUtil.validateEmail,
                ),
                GestureDetector(
                  onTap: () async {
                    String? selectedDistrict = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text(
                            'Select District',
                            style: TextStyle(color: AppColor.secondary),
                            textAlign: TextAlign.center,
                          ),
                          children:
                              AppListElements.districts.map((String district) {
                            return SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, district);
                              },
                              child: Text(
                                district,
                                style:
                                    const TextStyle(color: AppColor.secondary),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                        );
                      },
                    );
                    if (selectedDistrict != null) {
                      setState(() {
                        districtController.text = selectedDistrict;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: AuthTextFormField(
                      controller: districtController,
                      labelText: 'District',
                      hintText: 'Select your district',
                      validator: AuthUtil.validateDistrict,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    String? selectedService = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text(
                            'Select Service',
                            style: TextStyle(color: AppColor.secondary),
                            textAlign: TextAlign.center,
                          ),
                          children:
                              AppListElements.services.map((String service) {
                            return SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, service);
                              },
                              child: Text(
                                service,
                                style:
                                    const TextStyle(color: AppColor.secondary),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                        );
                      },
                    );
                    if (selectedService != null) {
                      setState(() {
                        serviceController.text = selectedService;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: AuthTextFormField(
                      controller: serviceController,
                      labelText: 'Service',
                      hintText: 'Select your service',
                      validator: AuthUtil.validateService,
                    ),
                  ),
                ),
                AuthTextFormField(
                  controller: experienceController,
                  textInputType: TextInputType.number,
                  labelText: 'Experience',
                  hintText: 'Enter your experience',
                  validator: AuthUtil.validateExperience,
                ),
                AuthTextFormField(
                  controller: passwordController,
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
                  buttonCallback: () {
                    if (formKey.currentState!.validate()) {
                      if (AuthUtil.validateImage(profileImage) != null ||
                          AuthUtil.validateImage(idCardImage) != null) {
                        ToastificationWidget.show(
                          context: context,
                          type: ToastificationType.error,
                          title: 'Validation Error',
                          description: AuthUtil.validateImage(profileImage) ??
                              AuthUtil.validateImage(idCardImage)!,
                          // backgroundColor: AppColor.toneSeven,
                          textColor: AppColor.secondary,
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const VerifyWorkerPage(),
                        ),
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
    );
  }
}
