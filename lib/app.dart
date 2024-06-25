import 'package:door_care_worker/app_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: const [],
      child: MultiBlocProvider(
        providers: const [],
        child: const MyAppView(),
      ),
    );
  }
}
