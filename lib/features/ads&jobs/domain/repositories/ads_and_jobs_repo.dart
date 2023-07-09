import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/job_ad.dart';
import '../entities/sliders_ads_jobs.dart';

abstract class AdsAndJobsRepo {
  Future<Either<Failure, List<SlidersAdsJobs>>> getAdsSliders(int page);
  Future<Either<Failure, List<SlidersAdsJobs>>> getJobsSliders(int page);
  Future<Either<Failure, List<JobAd>>> showAllAdsForFoundation(
      int page, int id);
  Future<Either<Failure, Unit>> addJob(JobAd job, int foundationId);
  Future<Either<Failure, Unit>> deleteJob(int id);
  Future<Either<Failure, Unit>> editJob(int id, JobAd job);
  Future<Either<Failure, List<JobAd>>> showAllJobForFoundation(
      int page, int id);
}
