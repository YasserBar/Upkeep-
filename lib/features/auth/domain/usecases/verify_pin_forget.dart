import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../entities/response_auth.dart';
import '../entities/verify_pin_forget.dart';
import '../repositories/auth_repo.dart';
import '../../../../core/errors/failures.dart';

class VerifyPinForgetUsecase {
  final AuthRepo repo;

  VerifyPinForgetUsecase(this.repo);

  Future<Either<Failure, ResponseAuth>> call(
      VerifyPinForget verifyPinForget, bool remmberMe) async {
    if (kDebugMode) {
      print("================================================================");
      print(verifyPinForget);
      print(
          "=================================================================");
    }
    return await repo.verifyPinForget(verifyPinForget, remmberMe);
  }
}
