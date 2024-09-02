import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import '../../../../../core/theme/color/app_color.dart';
import '../../../../core/widget/padding_widget.dart';
import '../../../../core/widget/toastification_widget.dart';
import '../../../auth/view/widget/loading_dialog.dart';
import '../../../home/data/model/fetch_all_service_model.dart';
import '../../../navigation_menu/view/page/navigation_menu.dart';
import '../../bloc/bloc/commit_booked_service_bloc.dart';
import '../widgets/bottom_app_bar_widget.dart';
import '../widgets/image_widget.dart';
import '../widgets/location_fetching_widget.dart';
import '../widgets/detail_row_widget.dart';

class ServiceDetailsPage extends StatelessWidget {
  final FetchAllServiceModel service;

  const ServiceDetailsPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommitBookedServiceBloc, CommitBookedServiceState>(
      listener: (context, state) {
        if (state is CommitBookedServiceLoadingState) {
          LoadingDialog.show(context);
        } else if (state is CommitBookedServiceSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => NavigationMenu()),
            (route) => false,
          );
          ToastificationWidget.show(
            context: context,
            type: ToastificationType.success,
            title: 'Success',
            description: 'Successfully commited service',
          );
        } else if (state is CommitBookedServiceFailState) {
          Navigator.pop(context);
          ToastificationWidget.show(
            context: context,
            type: ToastificationType.error,
            title: 'Error',
            description: 'Failed to commit a service. Please try again.',
          );
        }
      },
      child: Scaffold(
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
                      value: service.startTime.toString(),
                    ),
                    const SizedBox(height: 10),
                    DetailRowWidget(
                        icon: IconlyLight.timeSquare,
                        label: 'End Time: ',
                        value: service.endTime.toString()),
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
        bottomNavigationBar: BottomAppBarWidget(
          leftButtonText: 'Back',
          rightButtonText: 'Commit Now',
          onLeftButtonPressed: () {
            Navigator.of(context).pop();
          },
          onRightButtonPressed: () {
            context.read<CommitBookedServiceBloc>().add(
                  CommitABookedServiceEvent(
                    serviceId: service.id,
                  ),
                );
          },
        ),
      ),
    );
  }
}
