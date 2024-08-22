part of 'commit_booked_service_bloc.dart';

sealed class CommitBookedServiceEvent extends Equatable {
  const CommitBookedServiceEvent();

  @override
  List<Object> get props => [];
}

final class CommitABookedServiceEvent extends CommitBookedServiceEvent {
  final String serviceId;
  const CommitABookedServiceEvent({
    required this.serviceId,
  });
}
