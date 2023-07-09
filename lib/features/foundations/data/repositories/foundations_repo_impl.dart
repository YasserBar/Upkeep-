import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/get_message.dart';
import '../../../../core/helpers/get_token.dart';
import '../../../../core/helpers/network_info.dart';
import '../../../../main.dart';
import '../../../auth/data/datasources/auth_local_data_source.dart';
import '../../domain/entities/filter_foundations.dart';
import '../../domain/entities/foundation.dart';
import '../../domain/repositories/foundations_repo.dart';
import '../datasources/foundations_remote_data_source.dart';
import '../models/filtier_foundation.dart';
import '../models/foundation_model.dart';

typedef GetListFoundations = Future<List<FoundationModel>> Function();

class FoundationsRepoImpl extends FoundationsRepo {
  final FoundationsRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  FoundationsRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Foundation>>> filterFoundations(
      FilterFoundations filterFoundation, int page) async {
    final FilterFoundationsModel filterFoundationsModel =
        FilterFoundationsModel(
      cityId: filterFoundation.cityId,
      countryId: filterFoundation.countryId,
      regionId: filterFoundation.regionId,
      subServiceId: filterFoundation.subServiceId,
    );
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );

    return await _getFoundation(() {
      return remoteDataSource.filterFoundations(
          filterFoundationsModel, page, token!);
    });
  }

  @override
  Future<Either<Failure, List<Foundation>>> getAllFoundationsForOwner(
      int page) async {
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );
    return await _getFoundation(() {
      return remoteDataSource.getAllFoundationsForOwner(page, token!);
    });
  }

  Future<Either<Failure, List<Foundation>>> _getFoundation(
      GetListFoundations func) async {
    return performRequest<List<Foundation>>(func, networkInfo);
  }
}
