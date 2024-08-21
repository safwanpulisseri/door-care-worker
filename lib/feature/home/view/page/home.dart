import 'package:doorcareworker/feature/drawer/home_drawer.dart';
import 'package:doorcareworker/feature/home/view/widget/search_widget.dart';
import 'package:doorcareworker/core/theme/color/app_color.dart';
import 'package:doorcareworker/core/widget/padding_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/util/jason_asset.dart';
import '../../../../core/widget/opacity_container.dart';
import '../../../auth/bloc/auth_bloc/auth_bloc.dart';
import '../../../auth/data/service/local/auth_local_service.dart';
import '../../bloc/bloc/fetch_all_added_services_bloc.dart';
import '../../data/repository/fetch_all_services_repo.dart.dart';
import '../../data/service/remote/fetch_all_services_remote_service.dart';
import '../widget/review_card.dart';
import '../widget/service_card.dart';

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
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
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
          child: ListView(
            children: [
              Column(
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
                  const SearchWidget(),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const OpacityContainer(),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'New Works',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: AppColor.secondary,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<FetchAllAddedServicesBloc,
                      FetchAllAddedServicesState>(
                    builder: (context, state) {
                      if (state is FetchAllAddedServicesLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FetchAllAddedServicesSuccessState) {
                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.fetchAllServiceModel.length,
                            itemBuilder: (context, index) {
                              final service = state.fetchAllServiceModel[index];
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => ServiceDetailsPage(
                                  //       service: service,
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: ServiceCard(
                                  image: service.serviceImg,
                                  title: service.serviceName,
                                ),
                              );
                            },
                          ),
                        );
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
                  Row(
                    children: [
                      const OpacityContainer(),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Customer Reviews',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: AppColor.secondary,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        ReviewCard(),
                        ReviewCard(),
                        ReviewCard(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Row(
                  //   children: [
                  //     const OpacityContainer(),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     Text(
                  //       'Join Our Team',
                  //       style:
                  //           Theme.of(context).textTheme.headlineLarge?.copyWith(
                  //                 color: AppColor.secondary,
                  //               ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 10),
                  // const JoinOurTeamCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
