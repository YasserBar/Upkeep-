import '../entities/verify_pin_signup.dart';

class VerifyPinForget extends VerifyPinSignup {
  final String passwordConfirmation;

  const VerifyPinForget({
    required String email,
    required String password,
    required int verificationCode,
    required this.passwordConfirmation,
  }) : super(
            email: email,
            password: password,
            verificationCode: verificationCode);

  @override
  List<Object> get props {
    return [verificationCode, passwordConfirmation, email, password];
  }
}
