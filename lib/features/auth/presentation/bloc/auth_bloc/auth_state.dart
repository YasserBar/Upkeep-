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

class SuccessAuthProviderState extends AuthState {
  final String message;

  const SuccessAuthProviderState({required this.message});

  @override
  List<Object> get props => [message];
}