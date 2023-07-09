import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repo.dart';

class ForgetPasswordUsecase {
  final AuthRepo repo;

  ForgetPasswordUsecase(this.repo);

  Future<Either<Failure, Unit>> call(String email) async {
    return await repo.forgetPassword(email);
  }
}
