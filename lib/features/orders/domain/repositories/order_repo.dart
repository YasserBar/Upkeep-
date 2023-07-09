import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/order.dart';

abstract class OrderRepo {
  Future<Either<Failure, List<MyOrder>>> getAllOrder(int page);
  Future<Either<Failure, Unit>> cancelOrder(int orderId);
  Future<Either<Failure, Unit>> setAssessment(int orderId, int assessment);
  Future<Either<Failure, Unit>> blockUserService(
      int userId, int foundationServiceId);
  Future<Either<Failure, Unit>> blockUserFoundation(int userId, int foundationId);
  Future<Either<Failure, Unit>> acceptOrder(int orderId);
  Future<Either<Failure, Unit>> rejectedOrder(int orderId);
  Future<Either<Failure, List<MyOrder>>> getAllOrderForService(
      int page, int id);
  Future<Either<Failure, List<MyOrder>>> getAllOrderForAllService(
      int page, int foundationId);
}
