import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/job_ad.dart';
import '../repositories/ads_and_jobs_repo.dart';

class ShowAllJobForFoundationUsecase {
  final AdsAndJobsRepo repo;

  ShowAllJobForFoundationUsecase(this.repo);

  Future<Either<Failure, List<JobAd>>> call(int page, int id) async {
    return await repo.showAllJobForFoundation(page, id);
  }
}
