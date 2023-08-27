import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/features/foundations/domain/usecases/stop_foundation_usecase.dart';

import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';

part 'stop_foundation_event.dart';
part 'stop_foundation_state.dart';

class StopFoundationBloc extends Bloc<StopFoundationEvent, StopFoundationState> {
  final StopFoundationUsecase stopServiceUsecase;
  StopFoundationBloc({
    required this.stopServiceUsecase,
  }) : super(StopFoundationInitial()) {
    on<StopFoundationEvent>((event, emit) async {
      if (event is DoStopFoundationEvent) {
        emit(LoadingStopFoundationState());
        final failureOrDoneMessage = await stopServiceUsecase(event.id);
        emit(
          eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      }
    });
  }
}

StopFoundationState eitherDoneMessageOrErrorStateResponse(
    Either<Failure, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorStopFoundationState(
      mapFailureToMessage(failure),
    ),
    (myService) => SuccessStopFoundationState(Success_MESSAGE),
  );
}
