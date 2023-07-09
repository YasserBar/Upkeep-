import 'package:equatable/equatable.dart';

import 'base.dart';

class VerifyPinSignup extends Base with EquatableMixin {
  final int verificationCode;

  const VerifyPinSignup({
    required String email,
    required String password,
    required this.verificationCode,
  }) : super(email: email, password: password);

  @override
  List<Object> get props {
    return [email, password, verificationCode];
  }
}
