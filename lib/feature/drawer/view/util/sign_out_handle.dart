import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/widget/alert_dialogue_widget.dart';
import '../../../../core/widget/toastification_widget.dart';
import '../../../auth/bloc/auth_bloc/auth_bloc.dart';
import '../../../auth/view/page/sign_in_page.dart';

final class SignOutHandle {
  SignOutHandle._();

  static void showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'Confirm Sign Out',
          content: 'Are you sure you want to sign out?',
          buttonText: 'Sign Out',
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            context.read<AuthBloc>().add(SignOutEvent());
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInPage(),
              ),
              (route) => false,
            );
            ToastificationWidget.show(
              context: context,
              type: ToastificationType.success,
              title: 'Success',
              description: 'You have been signed out successfully.',
              textColor: AppColor.secondary,
            );
          },
        );
      },
    );
  }
}
