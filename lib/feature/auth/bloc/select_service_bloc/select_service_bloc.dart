// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/model/service_model.dart';
import '../../data/repository/select_service_repo.dart';
part 'select_service_event.dart';
part 'select_service_state.dart';

class SelectServiceBloc extends Bloc<SelectServiceEvent, SelectServiceState> {
  final FetchAllAddedServiceRepo _fetchAllAddedServiceRepo;
  SelectServiceBloc(this._fetchAllAddedServiceRepo)
      : super(SelectServiceInitialState()) {
    on<FetchAllServicesEvent>((event, emit) async {
      emit(FetchAllAddedServicesLoadingState());
      try {
        final List<SelectServiceModel> fetchAllServiceModel =
            await _fetchAllAddedServiceRepo.fetchServicesDetails();
        emit(FetchAllAddedServicesSuccessState(
            fetchAllServiceModel: fetchAllServiceModel));
      } catch (e) {
        emit(FetchAllAddedServicesFailState());
      }
    });
  }
}
