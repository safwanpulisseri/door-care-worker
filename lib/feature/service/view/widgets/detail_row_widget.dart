import 'package:flutter/material.dart';
import '../../../../core/theme/color/app_color.dart';

class DetailRowWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DetailRowWidget({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.toneThree.withOpacity(0.7),
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Icon(icon),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColor.secondary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: AppColor.secondary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}