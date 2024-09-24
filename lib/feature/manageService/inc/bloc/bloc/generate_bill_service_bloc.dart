import 'dart:developer';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repository/generate_bill_repo.dart';
part 'generate_bill_service_event.dart';
part 'generate_bill_service_state.dart';

class GenerateBillServiceBloc
    extends Bloc<GenerateBillServiceEvent, GenerateBillServiceState> {
  final GenerateBillServiceRepo _generateBillServiceRepo;
  GenerateBillServiceBloc(this._generateBillServiceRepo)
      : super(GenerateBillServiceInitialState()) {
    on<GeneratePaymentBillServiceEvent>((event, emit) async {
      emit(GenerateBillServiceLoadingState());
      try {
        var response = await _generateBillServiceRepo.generateBillRepo(
          bookingId: event.bookingId,
          bookingPrice: event.serviceCharge,
        );
        if (response.statusCode == 200) {
          emit(GenerateBillServiceSuccessState());
        } else {
          emit(GenerateBillServiceFailState());
          log('GenerateBillServiceFailState failed: ${response.statusCode}');
          throw Exception('GenerateBillServiceFailState failed');
        }
      } catch (e) {
        log(e.toString());
        emit(GenerateBillServiceFailState());
      }
    });
  }
}
