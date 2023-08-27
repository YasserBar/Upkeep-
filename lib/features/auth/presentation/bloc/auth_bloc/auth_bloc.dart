import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';
import '../../../domain/entities/login.dart';
import '../../../domain/entities/response_auth.dart';
import '../../../domain/entities/signup.dart';
import '../../../domain/entities/verify_pin_forget.dart';
import '../../../domain/entities/verify_pin_signup.dart';
import '../../../domain/usecases/forget_password.dart';
import '../../../domain/usecases/login_customer.dart';
import '../../../domain/usecases/login_provider.dart';
import '../../../domain/usecases/resend_pin.dart';
import '../../../domain/usecases/signup.dart';
import '../../../domain/usecases/verify_pin_forget.dart';
import '../../../domain/usecases/verify_pin_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginProviderUsecase loginProviderUsecase;
  final LoginCustomerUsecase loginCustomerUsecase;
  final SignupUsecase signupUsecase;
  final VerifyPinSignupUsecase verifyPinSignupUsecase;
  final VerifyPinForgetUsecase verifyPinForgetUsecase;
  final ResendPinUsecase resendPinUsecase;
  final ForgetPasswordUsecase forgetPasswordUsecase;
  AuthBloc({
    required this.loginCustomerUsecase,
    required this.loginProviderUsecase,
    required this.signupUsecase,
    required this.verifyPinSignupUsecase,
    required this.verifyPinForgetUsecase,
    required this.resendPinUsecase,
    required this.forgetPasswordUsecase,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginCustomerEvent) {
        emit(LoadingAuthState());

        final failureOrDoneMessage =
            await loginCustomerUsecase(event.login, event.rememberMe);

        emit(
          _eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      } else if (event is LoginProviderEvent) {
        emit(LoadingAuthState());

        final failureOrDoneMessage =
            await loginProviderUsecase(event.login, event.rememberMe);

        emit(
          _eitherDoneMessageOrErrorStateResponseProvider(
              failureOrDoneMessage, Success_MESSAGE),
        );
      } else if (event is SignupEvent) {
        emit(LoadingAuthState());

        final failureOrDoneMessage = await signupUsecase(event.signup);

        emit(
          _eitherDoneMessageOrErrorStateSignupUnit(
              failureOrDoneMessage, Success_MESSAGE),
        );
      } else if (event is VerifyPinSignupEvent) {
        emit(LoadingAuthState());

        final failureOrDoneMessage = await verifyPinSignupUsecase(
            event.verifyPinSignup, event.rememberMe);

        emit(
          _eitherDoneMessageOrErrorStateVerifyPinSignupResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      } else if (event is VerifyPinForgetEvent) {
        emit(LoadingAuthState());

        final failureOrDoneMessage = await verifyPinForgetUsecase(
            event.verifyPinForget, event.rememberMe);

        emit(
          _eitherDoneMessageOrErrorStateVerifyPinForgetResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      } else if (event is ForgetPasswordEvent) {
        emit(LoadingAuthState());

        final failureOrDoneMessage = await forgetPasswordUsecase(event.email);

        emit(
          _eitherDoneMessageOrErrorStateForgetPasswordUnit(
              failureOrDoneMessage, Success_MESSAGE),
        );
      } else if (event is ResendPinEvent) {
        emit(LoadingAuthState());

        final failureOrDoneMessage = await resendPinUsecase(event.email);

        emit(
          _eitherDoneMessageOrErrorStateResendPinUnit(
              failureOrDoneMessage, Success_MESSAGE),
        );
      }
    });
  }

  AuthState _eitherDoneMessageOrErrorStateResponse(
      Either<Failure, ResponseAuth> either, String message) {
    return either.fold(
      (failure) => ErrorAuthState(
        message: mapFailureToMessage(failure),
      ),
      (responseAuth) => SuccessAuthState(message: message),
    );
  }

  AuthState _eitherDoneMessageOrErrorStateSignupUnit(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAuthState(
        message: mapFailureToMessage(failure),
      ),
      (responseAuth) => SuccessSignupState(message: message),
    );
  }

  AuthState _eitherDoneMessageOrErrorStateForgetPasswordUnit(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAuthState(
        message: mapFailureToMessage(failure),
      ),
      (responseAuth) => SuccessForgetPasswordState(message: message),
    );
  }

  AuthState _eitherDoneMessageOrErrorStateResendPinUnit(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAuthState(
        message: mapFailureToMessage(failure),
      ),
      (responseAuth) => SuccessResendPinState(message: message),
    );
  }

  AuthState _eitherDoneMessageOrErrorStateVerifyPinSignupResponse(
      Either<Failure, ResponseAuth> either, String message) {
    return either.fold(
      (failure) => ErrorAuthState(
        message: mapFailureToMessage(failure),
      ),
      (responseAuth) => SuccessVerifyPinSignupState(message: message),
    );
  }

  AuthState _eitherDoneMessageOrErrorStateVerifyPinForgetResponse(
      Either<Failure, ResponseAuth> either, String message) {
    return either.fold(
      (failure) => ErrorAuthState(
        message: mapFailureToMessage(failure),
      ),
      (responseAuth) => SuccessVerifyPinForgetState(message: message),
    );
  }

  AuthState _eitherDoneMessageOrErrorStateResponseProvider(
      Either<Failure, ResponseAuth> either, String message) {
    return either.fold(
      (failure) => ErrorAuthState(
        message: mapFailureToMessage(failure),
      ),
      (responseAuth) => SuccessAuthProviderState(message: message),
    );
  }
}
