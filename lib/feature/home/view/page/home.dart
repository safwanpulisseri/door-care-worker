import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../widget/service_card.dart';
import '../../../drawer/home_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/jason_asset.dart';
import '../../../../core/widget/opacity_container.dart';
import '../../../../core/widget/padding_widget.dart';
import '../../../auth/bloc/auth_bloc/auth_bloc.dart';
import '../../../auth/data/service/local/auth_local_service.dart';
import '../../../service/view/page/booked_service_details.dart';
import '../../bloc/bloc/fetch_all_added_services_bloc.dart';
import '../../data/repository/fetch_all_services_repo.dart.dart';
import '../../data/service/remote/fetch_all_services_remote_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchAllAddedServicesBloc(FetchAllServiceRepo(
        FetchAllPendingServicesRemoteService(),
        AuthLocalService(),
      ))
        ..add(FetchAllServicesEvent()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          title: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccessState) {
                final userName = state.userModel.name;
                return Text(
                  'HELLO ${userName.toUpperCase()} 👋',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                );
              } else {
                return const Text('HELLO USER 👋');
              }
            },
          ),
          backgroundColor: AppColor.background,
        ),
        drawer: const CustomDrawer(),
        body: PaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What you are looking for today',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColor.secondary,
                      fontSize: 35,
                    ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const OpacityContainer(),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'New Works',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppColor.secondary,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<FetchAllAddedServicesBloc,
                    FetchAllAddedServicesState>(
                  builder: (context, state) {
                    if (state is FetchAllAddedServicesLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FetchAllAddedServicesSuccessState) {
                      if (state.fetchAllServiceModel.isEmpty) {
                        return Center(
                          child: Column(
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
                      } else {
                        return ListView.builder(
                          itemCount: state.fetchAllServiceModel.length,
                          itemBuilder: (context, index) {
                            final service = state.fetchAllServiceModel[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ServiceDetailsPage(
                                      service: service,
                                    ),
                                  ),
                                );
                              },
                              child: ServiceCard(
                                image: service.serviceImg,
                                title: service.serviceName,
                                date: service.date,
                              ),
                            );
                          },
                        );
                      }
                    } else if (state is FetchAllAddedServicesFailState) {
                      return Center(
                        child: Column(
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
            ],
          ),
        ),
      ),
    );
  }
}
