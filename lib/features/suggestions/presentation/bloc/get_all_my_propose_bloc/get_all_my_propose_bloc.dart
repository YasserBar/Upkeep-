import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';
import '../../../../../main.dart';
import '../../../domain/entities/my_suggestions.dart';
import '../../../domain/usecases/get_all_my_propose_usecase.dart';

part 'get_all_my_propose_event.dart';
part 'get_all_my_propose_state.dart';

class GetAllMyProposeBloc
    extends Bloc<GetAllMyProposeEvent, GetAllMyProposeState> {
  GetAllMyProposeUsecase getAllMyProposeUsecase;
  GetAllMyProposeBloc({required this.getAllMyProposeUsecase})
      : super(GetAllMyProposeInitial()) {
    on<GetAllMyProposeEvent>((event, emit) async {
      if (event is GetAllMySuggestionEvent) {
        emit(LoadingGetAllMyPropose());

        final failureOrDoneMessage =
            await getAllMyProposeUsecase(globalFoundationId!, 1);

        emit(
          _eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      }
    });
  }
}

GetAllMyProposeState _eitherDoneMessageOrErrorStateResponse(
    Either<Failure, List<MySuggestion>> either, String message) {
  return either.fold(
    (failure) => ErrorGetAllMyPropose(
      message: mapFailureToMessage(failure),
    ),
    (mySuggestion) => SuccessGetAllMyPropose(mySuggestion),
  );
}
