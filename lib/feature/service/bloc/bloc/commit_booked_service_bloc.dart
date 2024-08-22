import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repository/commit_new_service_repo.dart';
part 'commit_booked_service_event.dart';
part 'commit_booked_service_state.dart';

class CommitBookedServiceBloc
    extends Bloc<CommitBookedServiceEvent, CommitBookedServiceState> {
  final CommitNewServiceRepo _commitNewServiceRepo;
  CommitBookedServiceBloc(this._commitNewServiceRepo)
      : super(CommitBookedServiceInitialState()) {
    on<CommitABookedServiceEvent>((event, emit) async {
      emit(CommitBookedServiceLoadingState());
      try {
        var response = await _commitNewServiceRepo.commitNewService(
          serviceId: event.serviceId,
        );
        if (response.statusCode == 200) {
          emit(CommitBookedServiceSuccessState());
        } else {
          emit(CommitBookedServiceFailState());
          log('commit/accept a new service failed: ${response.statusCode}');
          throw Exception('commit/accept a new service failed');
        }
      } catch (e) {
        log(e.toString());
        emit(CommitBookedServiceFailState());
      }
    });
  }
}
