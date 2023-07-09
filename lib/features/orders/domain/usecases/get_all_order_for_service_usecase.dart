import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/order.dart';
import '../repositories/order_repo.dart';

class GetAllOrderForServiceUsecase {
  final OrderRepo repo;

  GetAllOrderForServiceUsecase(this.repo);

  Future<Either<Failure, List<MyOrder>>> call(int page, int id) async {
    return await repo.getAllOrderForService(page, id);
  }
}
