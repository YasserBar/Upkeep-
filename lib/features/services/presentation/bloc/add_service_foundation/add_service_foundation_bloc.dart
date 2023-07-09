import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';
import '../../../domain/entities/add_service.dart';
import '../../../domain/usecases/add_service_to_foundation_usecase.dart';

part 'add_service_foundation_event.dart';
part 'add_service_foundation_state.dart';

class AddServiceFoundationBloc
    extends Bloc<AddServiceFoundationEvent, AddServiceFoundationState> {
  final AddServiceToFoundationUsecase addServiceToFoundationUsecase;
  AddServiceFoundationBloc({required this.addServiceToFoundationUsecase})
      : super(AddServiceFoundationInitial()) {
    on<AddServiceFoundationEvent>((event, emit) async {
      if (event is AddServiceToFoundationEvent) {
        emit(LoadingAddServiceFoundationState());

        final failureOrDoneMessage =
            await addServiceToFoundationUsecase(event.myService);
        emit(
          eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      }
    });
  }
}

AddServiceFoundationState eitherDoneMessageOrErrorStateResponse(
    Either<Failure, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorAddServiceFoundationState(
      mapFailureToMessage(failure),
    ),
    (myService) => SuccessAddServiceFoundationState(Success_MESSAGE),
  );
}
