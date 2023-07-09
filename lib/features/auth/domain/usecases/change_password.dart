import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/change_password.dart';
import '../repositories/auth_repo.dart';

class ChangePasswordUsecase {
  final AuthRepo repo;

  ChangePasswordUsecase(this.repo);

  Future<Either<Failure, Unit>> call(ChangePassword changePassword) async {
    return await repo.changePassword(changePassword);
  }
}
