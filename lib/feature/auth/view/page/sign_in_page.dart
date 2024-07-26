import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/svg_asset.dart';
import '../../../../core/widget/padding_widget.dart';
import '../../../../core/widget/toastification_widget.dart';
import '../../../navigation_menu/view/page/navigation_menu.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../util/auth_util.dart';
import '../widget/auth_button_widget.dart';
import '../widget/auth_textformfield_widget.dart';
import '../widget/loading_dialog.dart';
import 'sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          LoadingDialog.show(context);
        } else if (state is AuthSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const NavigationMenu(),
            ),
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
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: PaddingWidget(
              child: Column(
                children: [
                  const Spacer(
                    flex: 5,
                  ),
                  Center(
                    child: SvgPicture.asset(
                      AppSvgPath.mainLogo,
                    ),
                  ),
                  const Spacer(flex: 1),
                  Text(
                    'Sign in',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 35,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 2),
                  AuthTextFormField(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    labelText: 'E-mail',
                    hintText: 'Enter your email',
                    validator: AuthUtil.validateEmail,
                    prefixIcon: AppSvgPath.mailLogo,
                  ),
                  const Spacer(flex: 1),
                  AuthTextFormField(
                    controller: _passwordController,
                    textInputType: TextInputType.visiblePassword,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                    validator: AuthUtil.validatePassword,
                    prefixIcon: AppSvgPath.passwordLogo,
                    showPasswordToggle: true,
                  ),
                  const Spacer(flex: 1),
                  AuthButton(
                    buttonText: 'Sign In',
                    buttonCallback: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<AuthBloc>().add(
                              EmailSignInAuthEvent(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
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
                        MaterialPageRoute(builder: (ctx) => const SignUpPage()),
                      );
                    },
                    navigationTitle: "Don't have an account? ",
                    navigationSubtitle: "Join our team for free",
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  // const TermsAndConditionsWidget(),
                  const Spacer(
                    flex: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
