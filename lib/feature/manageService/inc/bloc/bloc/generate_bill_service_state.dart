part of 'generate_bill_service_bloc.dart';

sealed class GenerateBillServiceState extends Equatable {
  const GenerateBillServiceState();

  @override
  List<Object> get props => [];
}

final class GenerateBillServiceInitialState extends GenerateBillServiceState {}

final class GenerateBillServiceLoadingState extends GenerateBillServiceState {}

final class GenerateBillServiceSuccessState extends GenerateBillServiceState {}

final class GenerateBillServiceFailState extends GenerateBillServiceState {}
