import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/order_repo.dart';

class BlockUserServiceUsecase {
  final OrderRepo repo;

  BlockUserServiceUsecase(this.repo);

  Future<Either<Failure, Unit>> call(
      int userId, int foundationServiceId) async {
    return await repo.blockUserService(userId, foundationServiceId);
  }
}
