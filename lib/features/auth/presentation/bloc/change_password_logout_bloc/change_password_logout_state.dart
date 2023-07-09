import 'package:equatable/equatable.dart';

abstract class ChangePasswordLogoutState extends Equatable {
  const ChangePasswordLogoutState();
  @override
  List<Object> get props => [];
}

class ChangePasswordLogoutInitial extends ChangePasswordLogoutState {}

class LoadingChangePasswordLogoutState extends ChangePasswordLogoutState {}

class ErrorChangePasswordLogoutState extends ChangePasswordLogoutState {
  final String message;

  const ErrorChangePasswordLogoutState({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessChangePasswordLogoutState extends ChangePasswordLogoutState {
  final String message;

  const SuccessChangePasswordLogoutState({required this.message});

  @override
  List<Object> get props => [message];
}
