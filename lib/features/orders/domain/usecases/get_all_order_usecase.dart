import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/order.dart';
import '../repositories/order_repo.dart';

class GetAllOrderUsecase {
  final OrderRepo repo;

  GetAllOrderUsecase(this.repo);

  Future<Either<Failure, List<MyOrder>>> call(int page) async {
    return await repo.getAllOrder(page);
  }
}
