import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/login.dart';
import '../entities/response_auth.dart';
import '../repositories/auth_repo.dart';

class LoginProviderUsecase {
  final AuthRepo repo;

  LoginProviderUsecase(this.repo);

  Future<Either<Failure, ResponseAuth>> call(
      Login login, bool remmberMe) async {
    return await repo.loginProvider(login, remmberMe);
  }
}
