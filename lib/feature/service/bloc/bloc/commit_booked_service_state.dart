part of 'commit_booked_service_bloc.dart';

sealed class CommitBookedServiceState extends Equatable {
  const CommitBookedServiceState();

  @override
  List<Object> get props => [];
}

final class CommitBookedServiceInitialState extends CommitBookedServiceState {}

final class CommitBookedServiceLoadingState extends CommitBookedServiceState {}

final class CommitBookedServiceSuccessState extends CommitBookedServiceState {}

final class CommitBookedServiceFailState extends CommitBookedServiceState {}
