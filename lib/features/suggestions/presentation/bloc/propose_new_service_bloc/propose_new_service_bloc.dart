import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';
import '../../../domain/entities/propose.dart';
import '../../../domain/usecases/propose_new_service_usecase.dart';

part 'propose_new_service_event.dart';
part 'propose_new_service_state.dart';

class ProposeNewServiceBloc
    extends Bloc<ProposeNewServiceEvent, ProposeNewServiceState> {
  ProposeNewServiceUsecase proposeNewServiceUsecase;

  ProposeNewServiceBloc({required this.proposeNewServiceUsecase})
      : super(ProposeNewServiceInitial()) {
    on<ProposeNewServiceEvent>((event, emit) async {
      if (event is ProposeNewSuggestionEvent) {
        emit(const LoadingProposeNewServiceState());

        final failureOrDoneMessage =
            await proposeNewServiceUsecase(event.propose);

        emit(
          _eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      }
    });
  }
}

ProposeNewServiceState _eitherDoneMessageOrErrorStateResponse(
    Either<Failure, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorProposeNewServiceState(
      message: mapFailureToMessage(failure),
    ),
    (message) => const SuccessProposeNewServiceState(Success_MESSAGE),
  );
}
