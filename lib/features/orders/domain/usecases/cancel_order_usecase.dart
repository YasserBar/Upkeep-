import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/order_repo.dart';

class CancelOrderUsecase {
  final OrderRepo repo;

  CancelOrderUsecase(this.repo);

  Future<Either<Failure, Unit>> call(int orderId) async {
    return await repo.cancelOrder(orderId);
  }
}
