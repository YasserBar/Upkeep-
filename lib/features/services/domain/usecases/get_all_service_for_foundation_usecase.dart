import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/service_foundation.dart';
import '../repositories/service_repo.dart';

class GetAllServiceForFoundationUsecase {
  final ServiceRepo repo;

  GetAllServiceForFoundationUsecase(this.repo);

  Future<Either<Failure, List<ServiceFoundation>>> call(
      int foundationId, int page) async {
    return await repo.getAllServiceForFoundation(foundationId, page);
  }
}
