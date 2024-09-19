import 'package:doorcareworker/feature/manageService/inc/view/page/bill_generated_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import '../../../../../core/theme/color/app_color.dart';
import '../../../../../core/widget/opacity_container.dart';
import '../../../../../core/widget/toastification_widget.dart';
import '../../../../auth/view/widget/loading_dialog.dart';
import '../../../../drawer/view/widget/appbar_widget.dart';
import '../../bloc/bloc/generate_bill_service_bloc.dart';
import '../widget/time_widget.dart';
import 'package:intl/intl.dart';

class GenerateBillPage extends StatelessWidget {
  final String bookingId;
  final num firstHourCharge;

  const GenerateBillPage({
    super.key,
    required this.bookingId,
    required this.firstHourCharge,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController timeController = TextEditingController();

    return BlocListener<GenerateBillServiceBloc, GenerateBillServiceState>(
      listener: (context, state) {
        if (state is GenerateBillServiceLoadingState) {
          LoadingDialog.show(context);
        } else {
          // // Ensure the loading dialog is dismissed before any other action
          // Navigator.pop(context);

          if (state is GenerateBillServiceSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const BillGeneratedSuccessPage(),
              ),
              (route) => false,
            );

            ToastificationWidget.show(
              context: context,
              type: ToastificationType.success,
              title: 'Success',
              description: 'Service Bill Generated successfully',
            );
          } else if (state is GenerateBillServiceFailState) {
            ToastificationWidget.show(
              context: context,
              type: ToastificationType.error,
              title: 'Error',
              description: 'Failed to Generate Service Bill',
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBarSingle(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const OpacityContainer(),
                  const SizedBox(width: 10),
                  Text(
                    'Work Details',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppColor.secondary,
                          fontSize: 30,
                        ),
                  ),
                  const Spacer(),
                ],
              ),
              TimePickerWidget(
                workedTimeController: timeController,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  final totalServiceCharge =
                      _calculateTotalServiceCharge(timeController.text);

                  // Ensure totalServiceCharge is not empty or zero
                  if (totalServiceCharge == 0) {
                    ToastificationWidget.show(
                      context: context,
                      type: ToastificationType.warning,
                      title: 'Invalid Time',
                      description: 'Please enter a valid worked time.',
                    );
                    return;
                  }

                  // Dispatch the GeneratePaymentBillServiceEvent with bookingId and totalServiceCharge
                  context.read<GenerateBillServiceBloc>().add(
                        GeneratePaymentBillServiceEvent(
                          bookingId: bookingId,
                          serviceCharge: totalServiceCharge,
                        ),
                      );
                },
                child: const Text('Generate Bill'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  num _calculateTotalServiceCharge(String workedTimeStr) {
    // Parse the worked time from worker's input
    DateFormat dateFormat = DateFormat("HH:mm");
    DateTime workedDateTime = dateFormat.parse(workedTimeStr);

    // Calculate total worked hours
    num totalWorkedHours = workedDateTime.hour + (workedDateTime.minute / 60);

    // Calculate total service charge
    return totalWorkedHours * firstHourCharge;
  }
}
