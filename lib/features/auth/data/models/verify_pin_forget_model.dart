import '../../domain/entities/verify_pin_forget.dart';

class VerifyPinForgetModel extends VerifyPinForget {
  const VerifyPinForgetModel({
    required String email,
    required String password,
    required int verificationCode,
    required String passwordConfirmation,
  }) : super(
          email: email,
          password: password,
          verificationCode: verificationCode,
          passwordConfirmation: passwordConfirmation,
        );

  factory VerifyPinForgetModel.fromJson(Map<String, dynamic> json) {
    return VerifyPinForgetModel(
      email: json['email'] as String,
      password: json['password'] as String,
      verificationCode: json['verification_code'] as int,
      passwordConfirmation: json['password_confirmation'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'verification_code': verificationCode,
      'password_confirmation': passwordConfirmation,
    };
  }
}
