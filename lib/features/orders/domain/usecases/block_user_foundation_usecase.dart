import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/order_repo.dart';

class BlockUserFoundationUsecase {
  final OrderRepo repo;

  BlockUserFoundationUsecase(this.repo);

  Future<Either<Failure, Unit>> call(int userId, int foundationId) async {
    return await repo.blockUserFoundation(userId, foundationId);
  }
}
