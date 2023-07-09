import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/job_ad.dart';
import '../repositories/ads_and_jobs_repo.dart';

class EditJobUsecase {
  final AdsAndJobsRepo repo;

  EditJobUsecase(this.repo);

  Future<Either<Failure, Unit>> call(int id, JobAd job) async {
    return await repo.editJob(id, job);
  }
}
