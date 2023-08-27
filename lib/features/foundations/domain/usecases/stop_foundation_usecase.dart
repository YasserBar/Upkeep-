import 'package:dartz/dartz.dart';
import 'package:upkeep_plus/features/foundations/domain/repositories/foundations_repo.dart';

import '../../../../core/errors/failures.dart';

class StopFoundationUsecase {
  final FoundationsRepo repo;

  StopFoundationUsecase(this.repo);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repo.stopFoundation(id);
  }
}
