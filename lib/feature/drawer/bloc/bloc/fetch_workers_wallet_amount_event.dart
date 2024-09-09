part of 'fetch_workers_wallet_amount_bloc.dart';

sealed class FetchWorkersWalletAmountEvent extends Equatable {
  const FetchWorkersWalletAmountEvent();

  @override
  List<Object> get props => [];
}

final class FetchSpecificWorkerWalletAmountEvent
    extends FetchWorkersWalletAmountEvent {
  final String workerId;
  const FetchSpecificWorkerWalletAmountEvent({
    required this.workerId,
  });
}
