import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/foundation.dart';
import '../repositories/foundations_repo.dart';

class GetAllFoundationsForOwnerUsecase {
  final FoundationsRepo repo;

  GetAllFoundationsForOwnerUsecase(this.repo);

  Future<Either<Failure, List<Foundation>>> call(int page) async {
    return await repo.getAllFoundationsForOwner(page);
  }
}
