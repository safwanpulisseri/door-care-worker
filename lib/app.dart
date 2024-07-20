import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_view.dart';
import 'feature/auth/bloc/auth_bloc/auth_bloc.dart';
import 'feature/auth/data/repository/auth_repo.dart';
import 'feature/auth/data/service/remote/auth_remote_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepo(
            AuthRemoteService(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepo>()),
          )
        ],
        child: const MyAppView(),
      ),
    );
  }
}
