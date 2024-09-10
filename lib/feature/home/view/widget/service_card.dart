import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/color/app_color.dart';

class ServiceCard extends StatelessWidget {
  final String image;
  final String title;
  final DateTime date;

  const ServiceCard({
    super.key,
    required this.image,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 190,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColor.secondary,
                  fontSize: 17,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat('dd-MM-yyyy').format(date),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColor.toneThree,
                ),
          ),
        ],
      ),
    );
  }
}
