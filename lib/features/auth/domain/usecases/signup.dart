import 'package:dartz/dartz.dart';

import '../entities/signup.dart';
import '../repositories/auth_repo.dart';
import '../../../../core/errors/failures.dart';

class SignupUsecase {
  final AuthRepo repo;

  SignupUsecase(this.repo);

  Future<Either<Failure, Unit>> call(Signup signup) async {
    return await repo.signup(signup);
  }
}
