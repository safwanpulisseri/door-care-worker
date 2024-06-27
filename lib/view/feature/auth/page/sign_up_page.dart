import 'package:door_care_worker/view/feature/auth/page/verify_worker.dart';
import 'package:door_care_worker/view/feature/auth/widget/image_container.dart';
import 'package:door_care_worker/view/util/list_of_elements.dart';
import 'package:flutter/material.dart';
import '../../../theme/color/app_color.dart';
import '../../drawer/widget/appbar_widget.dart';
import '../../onboarding/widget/cutom_elevated_button.dart';
import '../widget/customTextFormField.dart';
import '../widget/customeGestureText.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                CustomTextFormField(
                  controller: firstNameController,
                  labelText: 'Name',
                  hintText: 'Enter your full name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: mobileController,
                  labelText: 'Mobile Number',
                  hintText: 'Enter your mobile number',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit mobile number';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
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
                    child: CustomTextFormField(
                      controller: districtController,
                      labelText: 'District',
                      hintText: 'Select your district',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your district';
                        }
                        return null;
                      },
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
                    child: CustomTextFormField(
                      controller: serviceController,
                      labelText: 'Service',
                      hintText: 'Select your service',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your service';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                CustomTextFormField(
                  controller: experienceController,
                  labelText: 'Experience',
                  hintText: 'Enter your experience',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your experience';
                    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Please enter a valid experience';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  showPasswordToggle: true,
                ),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  showPasswordToggle: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                const ImageContainerWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: CustomElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const VerifyWorkerPage(),
                          ),
                        );
                      }
                    },
                    text: 'Sign Up',
                    backgroundColor: AppColor.primary,
                    textColor: AppColor.background,
                    fontSize: 18,
                    width: double.infinity,
                    height: 50,
                  ),
                ),
                CustomGestureText(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  mainText: 'Already have an Account? ',
                  actionText: 'Sign in',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
