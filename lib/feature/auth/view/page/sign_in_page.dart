import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/svg_asset.dart';
import '../../../../core/widget/padding_widget.dart';
import '../../../../core/widget/toastification_widget.dart';
import '../../../home/page/home.dart';
import '../util/auth_util.dart';
import '../widget/auth_button_widget.dart';
import '../widget/auth_textformfield.dart';
import '../widget/terms_and_condition_widget.dart';
import 'sign_up_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
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
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  labelText: 'E-mail',
                  hintText: 'Enter your email',
                  validator: AuthUtil.validateEmail,
                  prefixIcon: AppSvgPath.mailLogo,
                ),
                const Spacer(flex: 1),
                AuthTextFormField(
                  controller: passwordController,
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
                    if (formKey.currentState?.validate() ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const HomePage(),
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
                const TermsAndConditionsWidget(),
                const Spacer(
                  flex: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
