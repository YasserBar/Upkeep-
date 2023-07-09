import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/order_repo.dart';

class SetAssessmentUsecase {
  final OrderRepo repo;

  SetAssessmentUsecase(this.repo);

  Future<Either<Failure, Unit>> call(int orderId, int assessment) async {
    return await repo.setAssessment(orderId, assessment);
  }
}
