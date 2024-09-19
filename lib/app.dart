import 'app_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/auth/bloc/auth_bloc/auth_bloc.dart';
import 'feature/auth/data/repository/auth_repo.dart';
import 'feature/auth/data/repository/select_service_repo.dart';
import 'feature/auth/data/service/local/auth_local_service.dart';
import 'feature/auth/data/service/remote/auth_remote_service.dart';
import 'feature/service/bloc/bloc/commit_booked_service_bloc.dart';
import 'feature/service/data/repository/commit_new_service_repo.dart';
import 'feature/auth/bloc/select_service_bloc/select_service_bloc.dart';
import 'feature/manageService/chat/bloc/bloc/create_conversation_bloc.dart';
import 'feature/manageService/inc/bloc/bloc/generate_bill_service_bloc.dart';
import 'feature/manageService/inc/data/repository/generate_bill_repo.dart';
import 'feature/auth/data/service/remote/select_service_remote_service.dart';
import 'feature/service/data/service/remote/commit_service_remote_service.dart';
import 'feature/manageService/inc/data/services/remote/generate_bill_remote.dart';
import 'feature/manageService/chat/data/service/remote/createConversationRemote.dart';
import 'package:doorcareworker/feature/manageService/chat/data/repository/createConversationRepo.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthLocalService(),
        ),
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
        ),
        RepositoryProvider(
          create: (context) => CommitNewServiceRepo(
            CommitServiceRemoteService(),
            AuthLocalService(),
          ),
        ),
        RepositoryProvider(
          create: (context) => Createconversationrepo(
            Createconversation(),
            AuthLocalService(),
          ),
        ),
        RepositoryProvider(
          create: (context) => GenerateBillServiceRepo(
            GenerateBillRemoteService(),
            AuthLocalService(),
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
          ),
          BlocProvider(
            create: (context) =>
                CommitBookedServiceBloc(context.read<CommitNewServiceRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                CreateConversationBloc(context.read<Createconversationrepo>()),
          ),
          BlocProvider(
            create: (context) => GenerateBillServiceBloc(
                context.read<GenerateBillServiceRepo>()),
          ),
        ],
        child: const MyAppView(),
      ),
    );
  }
}
