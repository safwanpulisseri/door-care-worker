part of 'generate_bill_service_bloc.dart';

sealed class GenerateBillServiceEvent extends Equatable {
  const GenerateBillServiceEvent();

  @override
  List<Object> get props => [];
}

final class GeneratePaymentBillServiceEvent extends GenerateBillServiceEvent {
  final String bookingId;
  final num serviceCharge;
  const GeneratePaymentBillServiceEvent({
    required this.bookingId,
    required this.serviceCharge,
  });
}
