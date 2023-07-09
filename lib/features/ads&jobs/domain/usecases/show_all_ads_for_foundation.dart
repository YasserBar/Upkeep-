import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/job_ad.dart';
import '../repositories/ads_and_jobs_repo.dart';

class ShowAllAdsForFoundationUsecase {
  final AdsAndJobsRepo repo;

  ShowAllAdsForFoundationUsecase(this.repo);

  Future<Either<Failure, List<JobAd>>> call(int page, int id) async {
    return await repo.showAllAdsForFoundation(page, id);
  }
}
