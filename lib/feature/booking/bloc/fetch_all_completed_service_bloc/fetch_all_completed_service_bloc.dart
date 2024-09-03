import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/model/fetch_all_commited_service_model.dart';
import '../../data/repository/fetch_all_completed_repo.dart';
part 'fetch_all_completed_service_event.dart';
part 'fetch_all_completed_service_state.dart';

class FetchAllCompletedServiceBloc
    extends Bloc<FetchAllCompletedServiceEvent, FetchAllCompletedServiceState> {
  FetchAllCompletedRepo _fetchAllCompletedRepo;
  FetchAllCompletedServiceBloc(this._fetchAllCompletedRepo)
      : super(FetchAllCompletedServiceInitialState()) {
    on<FetchAllCompletedServiceEvent>((event, emit) async {
      emit(FetchAllCompletedServiceLoadingState());
      try {
        final List<FetchAllCommitedServiceModel>
            fetchAllPaymentEnterdCompletedServiceModel =
            await _fetchAllCompletedRepo
                .fetchAllCompletedRemoteServiceDetails();
        emit(FetchAllCompletedServiceSuccessState(
            fetchAllCompletedServiceModel:
                fetchAllPaymentEnterdCompletedServiceModel));
      } catch (e) {
        emit(FetchAllCompletedServiceFailState());
      }
    });
  }
}
