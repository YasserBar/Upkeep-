part of 'auth_bloc.dart';
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}
class AuthInitial extends AuthState {}

class LoadingAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String message;

  const ErrorAuthState({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessAuthState extends AuthState {
  final String message;

  const SuccessAuthState({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessForgetPasswordState extends AuthState {
  final String message;

  const SuccessForgetPasswordState({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessSignupState extends AuthState {
  final String message;

  const SuccessSignupState({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessResendPinState extends AuthState {
  final String message;

  const SuccessResendPinState({required this.message});

  @override
  List<Object> get props => [message];
}
class SuccessVerifyPinForgetState extends AuthState {
  final String message;

  const SuccessVerifyPinForgetState({required this.message});

  @override
  List<Object> get props => [message];
}
class SuccessVerifyPinSignupState extends AuthState {
  final String message;

  const SuccessVerifyPinSignupState({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessAuthProviderState extends AuthState {
  final String message;

  const SuccessAuthProviderState({required this.message});

  @override
  List<Object> get props => [message];
}