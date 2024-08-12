import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_view.dart';
import 'feature/auth/bloc/auth_bloc/auth_bloc.dart';
import 'feature/auth/bloc/select_service_bloc/select_service_bloc.dart';
import 'feature/auth/data/repository/auth_repo.dart';
import 'feature/auth/data/repository/select_service_repo.dart';
import 'feature/auth/data/service/local/auth_local_service.dart';
import 'feature/auth/data/service/remote/auth_remote_service.dart';
import 'feature/auth/data/service/remote/select_service_remote_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepo(
            AuthRemoteService(),
            AuthLocalService(),
          ),
        ),
        RepositoryProvider(
          create: (context) => FetchAllAddedServiceRepo(
            SelectServiceRemoteService(),
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(context.read<AuthRepo>())..add(CheckUserEvent()),
          ),
          BlocProvider(
            create: (context) =>
                SelectServiceBloc(context.read<FetchAllAddedServiceRepo>()),
          )
        ],
        child: const MyAppView(),
      ),
    );
  }
}
