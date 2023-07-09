import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';
import '../../../domain/entities/add_service.dart';
import '../../../domain/usecases/edit_service_usecase.dart';
import '../../../domain/usecases/stop_service_usecase.dart';

part 'edit_service_foundation_event.dart';
part 'edit_service_foundation_state.dart';

class EditServiceFoundationBloc
    extends Bloc<EditServiceFoundationEvent, EditServiceFoundationState> {
  final EditServiceUsecase editServiceUsecase;
  final StopServiceUsecase stopServiceUsecase;
  EditServiceFoundationBloc({
    required this.editServiceUsecase,
    required this.stopServiceUsecase,
  }) : super(EditServiceFoundationInitial()) {
    on<EditServiceFoundationEvent>((event, emit) async {
      if (event is EditServiceForFoundationEvent) {
        emit(LoadingEditServiceFoundationState());

        final failureOrDoneMessage = await editServiceUsecase(event.myService);
        emit(
          eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      }
      if (event is StopServiceForFoundationEvent) {
        emit(LoadingEditServiceFoundationState());

        final failureOrDoneMessage = await stopServiceUsecase(event.id);
        emit(
          eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      }
    });
  }
}

EditServiceFoundationState eitherDoneMessageOrErrorStateResponse(
    Either<Failure, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorEditServiceFoundationState(
      mapFailureToMessage(failure),
    ),
    (myService) => SuccessEditServiceFoundationState(Success_MESSAGE),
  );
}
