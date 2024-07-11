// import 'package:flutter/material.dart';
// import '../../../../core/theme/color/app_color.dart';

// class CustomGestureText extends StatelessWidget {
//   final VoidCallback onTap;
//   final String mainText;
//   final String actionText;
//   final bool isSignIn;

//   const CustomGestureText({
//     super.key,
//     required this.onTap,
//     required this.mainText,
//     required this.actionText,
//     this.isSignIn = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             mainText,
//             style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//                   color: AppColor.secondary.withOpacity(0.5),
//                   fontSize: 13,
//                 ),
//           ),
//           Text(
//             actionText,
//             style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//                   color: AppColor.primary,
//                   fontSize: 13,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }
