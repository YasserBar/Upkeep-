import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repo.dart';

class LogoutUsecase {
  final AuthRepo repo;

  LogoutUsecase(this.repo);

  Future<Either<Failure, Unit>> call() async {
    return await repo.logout();
  }
}
