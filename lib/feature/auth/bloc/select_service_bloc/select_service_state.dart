part of 'select_service_bloc.dart';

sealed class SelectServiceState extends Equatable {
  const SelectServiceState();

  @override
  List<Object> get props => [];
}

final class SelectServiceInitialState extends SelectServiceState {}

final class FetchAllAddedServicesInitialState extends SelectServiceState {}

final class FetchAllAddedServicesLoadingState extends SelectServiceState {}

final class FetchAllAddedServicesSuccessState extends SelectServiceState {
  final List<SelectServiceModel> fetchAllServiceModel;
  const FetchAllAddedServicesSuccessState({
    required this.fetchAllServiceModel,
  });
}

final class FetchAllAddedServicesFailState extends SelectServiceState {}
