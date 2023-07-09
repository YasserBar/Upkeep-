import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failure_to_message.dart';
import '../../../domain/usecases/reservation_service_usecase.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationServiceUsecase reservationServiceUsecase;
  ReservationBloc({required this.reservationServiceUsecase})
      : super(AddReservationInitial()) {
    on<AddReservationEvent>((event, emit) async {
      emit(LoadingAddReservationState());
      final failureOrDoneMessage =
          await reservationServiceUsecase(event.reservation);
      emit(
        _eitherDoneMessageOrErrorState(failureOrDoneMessage, Success_MESSAGE),
      );
    });
  }
  ReservationState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddReservationState(
        message: FailureToMessage().mapFailureToMessage(failure),
      ),
      (_) => SuccessAddReservationState(message: message),
    );
  }
}
