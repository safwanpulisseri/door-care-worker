part of 'select_service_bloc.dart';

sealed class SelectServiceEvent extends Equatable {
  const SelectServiceEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllServicesEvent extends SelectServiceEvent {}
