import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/jason_asset.dart';
import '../../../auth/data/service/local/auth_local_service.dart';
import '../../bloc/fetch_all_completed_service_bloc/fetch_all_completed_service_bloc.dart';
import '../../data/repository/fetch_all_completed_repo.dart';
import '../../data/services/remote/fetch_all_completed_remote.dart';
import '../widgets/completed_card_widget.dart';

class DetailsOfCompletedServicePage extends StatelessWidget {
  const DetailsOfCompletedServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchAllCompletedServiceBloc(
        FetchAllCompletedRepo(FetchAllCompletedRemote(), AuthLocalService()),
      )..add(FetchAllPaymentEnteredServiceEvent()),
      child: Scaffold(
        body: BlocBuilder<FetchAllCompletedServiceBloc,
            FetchAllCompletedServiceState>(
          builder: (context, state) {
            if (state is FetchAllCompletedServiceLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchAllCompletedServiceSuccessState) {
              final services = state.fetchAllCompletedServiceModel;
              // Filter unpaid services
              final unpaidServices =
                  services.where((service) => !service.payment).toList();

              if (unpaidServices.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.ban,
                        color: AppColor.toneThree,
                        size: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'No Completed Services Available',
                        style: TextStyle(
                            color: AppColor.secondary.withOpacity(0.8)),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: unpaidServices.length,
                  itemBuilder: (context, index) {
                    final service = unpaidServices[index];
                    return CardWidgetTwo(service: service);
                  },
                ),
              );
            } else if (state is FetchAllCompletedServiceFailState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(AppJasonPath.failedToFetch,
                        height: 150, width: 150),
                    const Text(
                      'Failed to Fetch Services',
                      style: TextStyle(color: AppColor.toneSeven),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(AppJasonPath.failedToFetch,
                        height: 150, width: 150),
                    const Text(
                      'No Services Available',
                      style: TextStyle(color: AppColor.toneSeven),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
