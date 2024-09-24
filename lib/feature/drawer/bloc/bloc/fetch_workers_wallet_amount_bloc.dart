// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repository/fetch_wallet_amount_repo.dart';
part 'fetch_workers_wallet_amount_event.dart';
part 'fetch_workers_wallet_amount_state.dart';

class FetchWorkersWalletAmountBloc
    extends Bloc<FetchWorkersWalletAmountEvent, FetchWorkersWalletAmountState> {
  final FetchWalletAmountRepo _fetchWalletAmountRepo;
  FetchWorkersWalletAmountBloc(this._fetchWalletAmountRepo)
      : super(FetchWorkersWalletAmountInitialState()) {
    on<FetchSpecificWorkerWalletAmountEvent>((event, emit) async {
      emit(FetchWorkersWalletAmountLoadingState());
      try {
        final walletData =
            await _fetchWalletAmountRepo.fetchUsersAllDetailsForWalletAmount();

        // Filter wallet data based on the worker ID
        final workerWallet = walletData.firstWhere(
          (data) => data['_id'] == event.workerId,
          orElse: () => {
            '_id': event.workerId,
            'wallet': 0
          }, // Handle case where ID is not found
        );
        emit(FetchWorkersWalletAmountSuccessState(workerWallet));
      } catch (e) {
        emit(FetchWorkersWalletAmountFailState(e.toString()));
      }
    });
  }
}
