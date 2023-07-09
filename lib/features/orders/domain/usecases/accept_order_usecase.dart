import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/order_repo.dart';

class AcceptOrderUsecase {
  final OrderRepo repo;

  AcceptOrderUsecase(this.repo);

  Future<Either<Failure, Unit>> call(int orderId) async {
    return await repo.acceptOrder(orderId);
  }
}