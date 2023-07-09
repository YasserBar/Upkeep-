import 'package:dartz/dartz.dart';

import '../entities/response_auth.dart';
import '../entities/verify_pin_signup.dart';
import '../repositories/auth_repo.dart';
import '../../../../core/errors/failures.dart';

class VerifyPinSignupUsecase {
  final AuthRepo repo;

  VerifyPinSignupUsecase(this.repo);

  Future<Either<Failure, ResponseAuth>> call(
      VerifyPinSignup verifyPinSignup, bool remmberMe) async {
    return await repo.verifyPinSignup(verifyPinSignup, remmberMe);
  }
}
