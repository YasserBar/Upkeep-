import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repo.dart';

class ResendPinUsecase {
  final AuthRepo repo;

  ResendPinUsecase(this.repo);

  Future<Either<Failure, Unit>> call(String email) async {
    return await repo.resendPin(email);
  }
}
