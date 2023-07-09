import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/sliders_ads_jobs.dart';
import '../repositories/ads_and_jobs_repo.dart';

class GetAdsSlidersUsecase {
  final AdsAndJobsRepo repo;

  GetAdsSlidersUsecase(this.repo);

  Future<Either<Failure, List<SlidersAdsJobs>>> call(int page) async {
    return await repo.getAdsSliders(page);
  }
}
