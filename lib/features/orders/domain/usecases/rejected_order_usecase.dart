import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/order_repo.dart';

class RejectedOrderUsecase {
  final OrderRepo repo;

  RejectedOrderUsecase(this.repo);

  Future<Either<Failure, Unit>> call(int orderId) async {
    return await repo.rejectedOrder(orderId);
  }
}
