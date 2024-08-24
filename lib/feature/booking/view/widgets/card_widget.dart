import 'package:doorcareworker/feature/booking/view/widgets/location_fetching_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/png_asset.dart';
import '../../../../core/widget/padding_widget.dart';
import '../../../manageService/home/manage_service_home.dart';
import '../../data/model/fetch_all_commited_service_model.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.service,
  });

  final FetchAllCommitedServiceModel service;

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage: service.serviceImg.isNotEmpty
                        ? NetworkImage(service.serviceImg)
                        : const AssetImage(AppPngPath.homeCleanTwo),
                    // onBackgroundImageError:
                    //     (exception, stackTrace) {
                    //   // Optionally handle image loading errors here
                    // },
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.serviceName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Booking ID:${service.id}',
                        style: const TextStyle(
                          color: AppColor.toneThree,
                        ),
                      ),
                    ],
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
                      '${service.status}ted',
                      style: const TextStyle(color: AppColor.toneSix),
                    ),
                    backgroundColor: AppColor.toneSix.withOpacity(0.2),
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
                    label: const Text(
                      'Pending',
                      style: TextStyle(color: AppColor.toneSix),
                    ),
                    backgroundColor: AppColor.toneSix.withOpacity(0.2),
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
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset("assets/svg/booking_one.svg"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    DateFormat('dd-MM-yyyy').format(service.createdAt),
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
                latitude: service.latitude,
                longitude: service.longitude,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // context.read<CancelABookedPendingServiceBloc>().add(
                    //       CancelBookedPendingServiceEvent(
                    //         bookingId: service.id,
                    //       ),
                    //     );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageServiceHome(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Manage Service',
                    style: TextStyle(color: AppColor.background),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
