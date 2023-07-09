import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';
import '../../../domain/entities/job_ad.dart';
import '../../../domain/usecases/add_job._usecase.dart';
part 'add_job_event.dart';
part 'add_job_state.dart';

class AddJobBloc extends Bloc<AddJobEvent, AddJobState> {
  final AddJobUsecase addJobUsecase;
  AddJobBloc({required this.addJobUsecase}) : super(AddJobInitial()) {
    on<AddJobEvent>((event, emit) async {
      if (event is AddJobForFoundationEvent) {
        emit(const LoadingAddJobState());

        final failureOrDoneMessage =
            await addJobUsecase(event.job, event.foundationId);

        emit(
          _eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      }
    });
  }
}

AddJobState _eitherDoneMessageOrErrorStateResponse(
    Either<Failure, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorAddJobState(
      mapFailureToMessage(failure),
    ),
    (_) => SuccessAddJobState(message),
  );
}
