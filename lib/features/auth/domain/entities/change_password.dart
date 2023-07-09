import 'package:equatable/equatable.dart';

class ChangePassword extends Equatable {
  final String oldPassword;
  final String password;
  final String passwordConfirmation;

  const ChangePassword({
    required this.oldPassword,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object?> get props => [oldPassword, password, passwordConfirmation];
}
