import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';
import '../../../domain/usecases/stop_service_usecase.dart';

part 'stop_service_event.dart';
part 'stop_service_state.dart';

class StopServiceBloc extends Bloc<StopServiceEvent, StopServiceState> {
  final StopServiceUsecase stopServiceUsecase;
  StopServiceBloc({
    required this.stopServiceUsecase,
  }) : super(StopServiceInitial()) {
    on<StopServiceEvent>((event, emit) async {
      if (event is DoStopServiceEvent) {
        emit(LoadingStopServiceState());
        final failureOrDoneMessage = await stopServiceUsecase(event.id);
        emit(
          eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      }
    });
  }
}

StopServiceState eitherDoneMessageOrErrorStateResponse(
    Either<Failure, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorStopServiceState(
      mapFailureToMessage(failure),
    ),
    (myService) => SuccessStopServiceState(Success_MESSAGE),
  );
}
