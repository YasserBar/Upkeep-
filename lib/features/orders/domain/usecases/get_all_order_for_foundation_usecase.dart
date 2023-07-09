import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/order.dart';
import '../repositories/order_repo.dart';

class GetAllOrderForFoundationUsecase {
  final OrderRepo repo;

  GetAllOrderForFoundationUsecase(this.repo);

  Future<Either<Failure, List<MyOrder>>> call(
      int page, int foundationId) async {
    return await repo.getAllOrderForAllService(page, foundationId);
  }
}
