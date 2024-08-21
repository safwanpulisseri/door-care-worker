import 'package:flutter/material.dart';

import '../../../../core/theme/color/app_color.dart';
import '../../../home/data/model/fetch_all_service_model.dart';

class ServiceImageWidget extends StatelessWidget {
  const ServiceImageWidget({
    super.key,
    required this.service,
  });

  final FetchAllServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: Image.network(
            service.serviceImg,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColor.secondary.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        service.serviceName,
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: AppColor.background,
                                ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
