import 'package:door_care_worker/view/feature/auth/page/sign_up_page.dart';
import 'package:door_care_worker/view/feature/home/page/home.dart';
import 'package:door_care_worker/view/widget/padding_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../theme/color/app_color.dart';
import '../../../util/svg_asset.dart';
import '../../onboarding/widget/cutom_elevated_button.dart';
import '../util/auth_util.dart';
import '../widget/custom_textformfield.dart';
import '../widget/custome_gesture_text.dart';

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
                CustomTextFormField(
                  controller: emailController,
                  labelText: 'E-mail',
                  hintText: 'Enter your email',
                  validator: AuthUtil.validateEmail,
                  prefixIcon: AppSvgPath.mailLogo,
                ),
                const Spacer(flex: 1),
                CustomTextFormField(
                  controller: passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  obscureText: true,
                  validator: AuthUtil.validatePassword,
                  prefixIcon: AppSvgPath.passwordLogo,
                  showPasswordToggle: true,
                ),
                const Spacer(flex: 5),
                CustomElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const HomePage(),
                        ),
                      );
                    }
                  },
                  text: 'Sign In',
                  backgroundColor: AppColor.primary,
                  textColor: AppColor.background,
                  fontSize: 18,
                  width: double.infinity,
                  height: 50,
                ),
                const Spacer(
                  flex: 1,
                ),
                CustomGestureText(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx) => const SignUpPage()),
                    );
                  },
                  mainText: "Don't have an account? ",
                  actionText: 'Join our team for free',
                ),
                const Spacer(flex: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
