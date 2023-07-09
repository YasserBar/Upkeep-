import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';
import '../../../domain/usecases/change_password.dart';
import '../../../domain/usecases/logout.dart';
import 'change_password_logout_event.dart';
import 'change_password_logout_state.dart';

class ChangePasswordLogoutBloc
    extends Bloc<ChangePasswordLogoutEvent, ChangePasswordLogoutState> {
  final LogoutUsecase logoutUsecase;
  final ChangePasswordUsecase changePasswordUsecase;
  ChangePasswordLogoutBloc(
      {required this.logoutUsecase, required this.changePasswordUsecase})
      : super(ChangePasswordLogoutInitial()) {
    on<ChangePasswordLogoutEvent>((event, emit) async {
      if (event is ChangePasswordEvent) {
        emit(LoadingChangePasswordLogoutState());

        final failureOrDoneMessage =
            await changePasswordUsecase(event.changePassword);

        emit(
          _eitherDoneMessageOrErrorStateUnit(
              failureOrDoneMessage, Success_MESSAGE),
        );
      } else if (event is LogoutEvent) {
        emit(LoadingChangePasswordLogoutState());

        final failureOrDoneMessage = await logoutUsecase();

        emit(
          _eitherDoneMessageOrErrorStateUnit(
              failureOrDoneMessage, Success_MESSAGE),
        );
      }
    });
  }
}

ChangePasswordLogoutState _eitherDoneMessageOrErrorStateUnit(
    Either<Failure, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorChangePasswordLogoutState(
      message: mapFailureToMessage(failure),
    ),
    (responseAuth) => SuccessChangePasswordLogoutState(message: message),
  );
}
