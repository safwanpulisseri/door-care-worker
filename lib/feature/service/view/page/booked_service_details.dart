import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theme/color/app_color.dart';
import '../../../../core/widget/padding_widget.dart';
import '../../../home/data/model/fetch_all_service_model.dart';
import '../widgets/image_widget.dart';
import '../widgets/location_fetching_widget.dart';
import '../widgets/detail_row_widget.dart';

class ServiceDetailsPage extends StatelessWidget {
  final FetchAllServiceModel service;

  const ServiceDetailsPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Center(
            child: FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: 30,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Work Details',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColor.secondary,
                fontSize: 30,
              ),
        ),
        backgroundColor: AppColor.background,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ServiceImageWidget(service: service),
            PaddingWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),
                  DetailRowWidget(
                    icon: IconlyLight.bookmark,
                    label: 'Booking ID: ',
                    value: service.id,
                  ),
                  const SizedBox(height: 18),
                  DetailRowWidget(
                    icon: IconlyLight.profile,
                    label: 'User ID: ',
                    value: service.userId,
                  ),
                  const SizedBox(height: 18),
                  DetailRowWidget(
                    icon: IconlyLight.calendar,
                    label: 'Booked Date: ',
                    value: DateFormat('dd-MM-yyyy').format(service.createdAt),
                  ),
                  const SizedBox(height: 10),
                  DetailRowWidget(
                    icon: IconlyLight.calendar,
                    label: 'Work Date: ',
                    value: DateFormat('dd-MM-yyyy').format(service.date),
                  ),
                  const SizedBox(height: 10),
                  DetailRowWidget(
                    icon: IconlyLight.timeSquare,
                    label: 'Start Time: ',
                    value: DateFormat.jm().format(service.startTime),
                  ),
                  const SizedBox(height: 10),
                  DetailRowWidget(
                    icon: IconlyLight.timeSquare,
                    label: 'End Time: ',
                    value: DateFormat.jm().format(service.endTime),
                  ),
                  const SizedBox(height: 10),
                  LocationFetchingWidget(
                    latitude: service.latitude,
                    longitude: service.longitude,
                  ),
                  const SizedBox(height: 10),
                  DetailRowWidget(
                    icon: IconlyLight.wallet,
                    label: 'First Hour Charge: ',
                    value: service.firstHourCharge.toString(),
                  ),
                  const SizedBox(height: 10),
                  DetailRowWidget(
                    icon: IconlyLight.wallet,
                    label: 'Second Hour Charge: ',
                    value: service.laterHourCharge.toString(),
                  ),
                  const SizedBox(height: 10),
                  DetailRowWidget(
                    icon: IconlyLight.message,
                    label: 'User\'s Message: ',
                    value: service.description,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColor.textfield,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                backgroundColor: AppColor.textfield,
                foregroundColor: AppColor.secondary.withOpacity(0.7),
                side: BorderSide(
                  color: AppColor.toneThree.withOpacity(0.5),
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                // MaterialPageRoute(
                //     builder: (context) =>
                //         FindLocationBookService(service: service)),
                // );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                backgroundColor: AppColor.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Accept Now'),
            ),
          ],
        ),
      ),
    );
  }
}
