import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';
import '../../../domain/usecases/accept_order_usecase.dart';
import '../../../domain/usecases/rejected_order_usecase.dart';

part 'accept_rejected_order_event.dart';
part 'accept_rejected_order_state.dart';

class AcceptRejectedOrderBloc
    extends Bloc<AcceptRejectOrderEvent, AcceptRejectOrderState> {
  AcceptOrderUsecase acceptOrderUsecase;
  RejectedOrderUsecase rejectedOrderUsecase;
  late int id;
  AcceptRejectedOrderBloc(
      {required this.acceptOrderUsecase, required this.rejectedOrderUsecase})
      : super(AcceptRejectOrderInitial()) {
    on<AcceptRejectOrderEvent>((event, emit) async {
      if (event is AcceptOrderEvent) {
        emit(const LoadingAcceptRejectOrderState());

        final failureOrDoneMessage = await acceptOrderUsecase(event.orderId);

        emit(
          _eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      } else if (event is RejectedOrderEvent) {
        emit(const LoadingAcceptRejectOrderState());

        final failureOrDoneMessage = await rejectedOrderUsecase(event.orderId);

        emit(
          _eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      }
    });
  }
}

AcceptRejectOrderState _eitherDoneMessageOrErrorStateResponse(
    Either<Failure, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorAcceptRejectOrderState(
      mapFailureToMessage(failure),
    ),
    (message) => const SuccessAcceptRejectOrderState(Success_MESSAGE),
  );
}
