import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/ads_and_jobs_repo.dart';

class DeleteJobUsecase {
  final AdsAndJobsRepo repo;

  DeleteJobUsecase(this.repo);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repo.deleteJob(id);
  }
}
