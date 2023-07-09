import 'package:equatable/equatable.dart';

import '../../../domain/entities/change_password.dart';

abstract class ChangePasswordLogoutEvent extends Equatable {
  const ChangePasswordLogoutEvent();
  @override
  List<Object> get props => [];
}

class ChangePasswordEvent extends ChangePasswordLogoutEvent {
  final ChangePassword changePassword;

  const ChangePasswordEvent({required this.changePassword});

  @override
  List<Object> get props => [changePassword];
}

class LogoutEvent extends ChangePasswordLogoutEvent {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}
