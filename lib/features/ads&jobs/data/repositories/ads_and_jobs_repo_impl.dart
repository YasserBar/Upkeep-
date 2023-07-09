import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/get_message.dart';
import '../../../../core/helpers/get_token.dart';
import '../../../../core/helpers/network_info.dart';
import '../../../../main.dart';
import '../../../auth/data/datasources/auth_local_data_source.dart';
import '../../domain/entities/job_ad.dart';
import '../../domain/entities/sliders_ads_jobs.dart';
import '../../domain/repositories/ads_and_jobs_repo.dart';
import '../datasources/ads_and_jobs_remote_data_source.dart';
import '../models/job_ad.dart';
import '../models/sliders_ads_jobs.dart';

typedef GetListAdsAndJobs = Future<List<SlidersAdsJobsModel>> Function();
typedef GetJobs = Future<List<JobAd>> Function();

class AdsAndJobsRepoImpl extends AdsAndJobsRepo {
  final AdsAndJobsRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AdsAndJobsRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<SlidersAdsJobs>>> getAdsSliders(int page) async {
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
          (l) {
        return l;
      },
          (r) {
        token = r;
      },
    );

    return await _getSliders(() {
      return remoteDataSource.getAdsSliders(page, token!);
    });
  }

  @override
  Future<Either<Failure, List<SlidersAdsJobs>>> getJobsSliders(int page) async {
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
          (l) {
        return l;
      },
          (r) {
        token = r;
      },
    );

    return await _getSliders(() {
      return remoteDataSource.getJobsSliders(page, token!);
    });
  }

  @override
  Future<Either<Failure, List<JobAd>>> showAllAdsForFoundation(
      int page, int id) async {
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
          (l) {
        return l;
      },
          (r) {
        token = r;
      },
    );

    return await _getJobsAds(() {
      return remoteDataSource.showAllAdsForFoundation(page, token!, id);
    });
  }

  @override
  Future<Either<Failure, Unit>> addJob(JobAd job, int foundationId) async {
    JobAdModel jobModel = JobAdModel(
        title: job.title,
        description: job.description,
        photo: job.photo);
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
          (l) {
        return l;
      },
          (r) {
        token = r;
      },
    );

    return await getMessage(() {
      return remoteDataSource.addJob(token!, jobModel, foundationId);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, Unit>> deleteJob(int id) async {
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
          (l) {
        return l;
      },
          (r) {
        token = r;
      },
    );

    return await getMessage(() {
      return remoteDataSource.deleteJob(token!, id);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, Unit>> editJob(int id, JobAd job) async {
    JobAdModel jobModel = JobAdModel(
        title: job.title,
        description: job.description,
        photo: job.photo);
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
          (l) {
        return l;
      },
          (r) {
        token = r;
      },
    );

    return await getMessage(() {
      return remoteDataSource.editJob(token!, jobModel);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, List<JobAd>>> showAllJobForFoundation(
      int page, int id) async {
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
          (l) {
        return l;
      },
          (r) {
        token = r;
      },
    );

    return await _getJobsAds(() {
      return remoteDataSource.showAllJobForFoundation(page, token!, id);
    });
  }

  Future<Either<Failure, List<JobAd>>> _getJobsAds(GetJobs func) async {
    return performRequest<List<JobAd>>(func, networkInfo);
  }

  Future<Either<Failure, List<SlidersAdsJobsModel>>> _getSliders(
      GetListAdsAndJobs func) async {
    return performRequest<List<SlidersAdsJobsModel>>(func, networkInfo);
  }
}
