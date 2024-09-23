import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/png_asset.dart';
import '../../../../core/widget/padding_widget.dart';
import '../../data/model/fetch_all_commited_service_model.dart';
import 'location_fetching_widget.dart';

class CardWidgetTwo extends StatefulWidget {
  const CardWidgetTwo({
    super.key,
    required this.service,
  });

  final FetchAllCommitedServiceModel service;

  @override
  State<CardWidgetTwo> createState() => _CardWidgetTwoState();
}

class _CardWidgetTwoState extends State<CardWidgetTwo> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    // Create an instance of NumberFormat to format the price
    final numberFormat = NumberFormat('#,##0.00'); // For two decimal places
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColor.toneThree.withOpacity(0.4),
          ),
        ),
        child: PaddingWidget(
          // padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: widget.service.serviceImg.isNotEmpty
                        ? NetworkImage(widget.service.serviceImg)
                        : const AssetImage(AppPngPath.homeCleanTwo),
                    // onBackgroundImageError:
                    //     (exception, stackTrace) {
                    //   // Optionally handle image loading errors here
                    // },
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.service.serviceName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Text(
                            'Booking ID: ${widget.service.id}',
                            style: const TextStyle(
                              color: AppColor.toneThree,
                            ),
                            overflow: _isExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            maxLines: _isExpanded ? 2 : 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Work Status',
                    style: TextStyle(
                      color: AppColor.toneThree,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Chip(
                    side: BorderSide.none,
                    label: Text(
                      widget.service.status,
                      style: const TextStyle(color: AppColor.toneEight),
                    ),
                    backgroundColor: AppColor.toneOne.withOpacity(0.7),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment Status',
                    style: TextStyle(
                      color: AppColor.toneThree,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Chip(
                    side: BorderSide.none,
                    label: Text(
                      widget.service.payment ? 'Completed' : 'Pending',
                      style: TextStyle(
                        color: widget.service.payment
                            ? AppColor.toneEight
                            : AppColor.toneSix,
                      ),
                    ),
                    backgroundColor: widget.service.payment
                        ? AppColor.toneOne.withOpacity(0.7)
                        : AppColor.toneSix.withOpacity(0.2),
                  ),
                ],
              ),
              Row(
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
                        child: Icon(
                          IconlyLight.wallet,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '₹ ${numberFormat.format(widget.service.price)}',
                    style: const TextStyle(
                      color: AppColor.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
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
                        child: Icon(
                          IconlyLight.calendar,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    DateFormat('dd-MM-yyyy').format(widget.service.createdAt),
                    style: const TextStyle(
                      color: AppColor.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LocationFetchingWidget(
                latitude: widget.service.latitude,
                longitude: widget.service.longitude,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
