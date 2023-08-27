import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/features/services/domain/usecases/stop_service_usecase.dart';
import 'package:upkeep_plus/features/services/presentation/bloc/stop_service_bloc/stop_service_bloc.dart';

import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';


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
