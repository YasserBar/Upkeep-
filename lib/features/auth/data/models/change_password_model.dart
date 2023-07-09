import '../../domain/entities/change_password.dart';

class ChangePasswordModel extends ChangePassword {
  const ChangePasswordModel({
    required String oldPassword,
    required String password,
    required String passwordConfirmation,
  }) : super(
          oldPassword: oldPassword,
          password: password,
          passwordConfirmation: passwordConfirmation,
        );

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      oldPassword: json['old_password'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['password_confirmation'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'old_password': oldPassword,
      'password': password,
      'password_confirmation': passwordConfirmation
    };
  }
}
