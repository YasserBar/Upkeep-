import '../../domain/entities/verify_pin_signup.dart';

class VerifyPinSignupModel extends VerifyPinSignup {
  const VerifyPinSignupModel({
    required String email,
    required String password,
    required int verificationCode,
  }) : super(
          email: email,
          password: password,
          verificationCode: verificationCode,
        );

  factory VerifyPinSignupModel.fromJson(Map<String, dynamic> json) {
    return VerifyPinSignupModel(
      email: json['email'] as String,
      password: json['password'] as String,
      verificationCode: json['verification_code'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'verification_code': verificationCode,
    };
  }
}
