import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/job_ad.dart';
import '../repositories/ads_and_jobs_repo.dart';

class AddJobUsecase {
  final AdsAndJobsRepo repo;

  AddJobUsecase(this.repo);

  Future<Either<Failure, Unit>> call(JobAd job, int foundationId) async {
    return await repo.addJob(job, foundationId);
  }
}
