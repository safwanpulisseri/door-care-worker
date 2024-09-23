import 'package:flutter/material.dart';
import 'navigation_text.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  //final bool animate;
  const TermsAndConditionsWidget({
    //  this.animate = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavigationText(
          leadingText: "By proceeding, I accept Door Care",
          buttonText: 'T&C',
          callback: () {},
        ),
        NavigationText(
          leadingText: "and",
          buttonText: 'Privacy Policy.',
          callback: () {},
        ),
      ],
    );
  }
}
