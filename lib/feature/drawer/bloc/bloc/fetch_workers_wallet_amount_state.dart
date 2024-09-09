part of 'fetch_workers_wallet_amount_bloc.dart';

sealed class FetchWorkersWalletAmountState extends Equatable {
  const FetchWorkersWalletAmountState();

  @override
  List<Object> get props => [];
}

final class FetchWorkersWalletAmountInitialState
    extends FetchWorkersWalletAmountState {}

final class FetchWorkersWalletAmountLoadingState
    extends FetchWorkersWalletAmountState {}

final class FetchWorkersWalletAmountSuccessState
    extends FetchWorkersWalletAmountState {
  final Map<String, dynamic> workerWallet;
  const FetchWorkersWalletAmountSuccessState(
    this.workerWallet,
  );
}

final class FetchWorkersWalletAmountFailState
    extends FetchWorkersWalletAmountState {
  final String error;
  const FetchWorkersWalletAmountFailState(this.error);
}
