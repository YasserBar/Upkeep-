import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/date.dart';
import '../repositories/service_repo.dart';

class GetAvailableTimeUsecase {
  final ServiceRepo repo;

  GetAvailableTimeUsecase(this.repo);

  Future<Either<Failure, List<Date>>> call(int id) async {
    return await repo.getAvailableTime(id);
  }
}
