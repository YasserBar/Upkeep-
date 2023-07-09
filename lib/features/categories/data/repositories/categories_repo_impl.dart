import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/get_message.dart';
import '../../../../core/helpers/get_token.dart';
import '../../../../core/helpers/network_info.dart';
import '../../../../main.dart';
import '../../../auth/data/datasources/auth_local_data_source.dart';import '../../domain/entities/service.dart';
import '../../domain/repositories/categories_repo.dart';
import '../datasources/categories_remote_data_source.dart';
import '../models/service.dart';

typedef GetServices = Future<List<ServiceModel>> Function();

class CategoriesRepoImpl extends CategoriesRepo {
  final CategoriesRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoriesRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Service>>> getAllServiceInSystem(int page) async {
   final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
          (l) {
        return l;
      },
          (r) {
        token = r;
      },
    );
    return await _getServices(() {
      return remoteDataSource.getAllServiceInSystem(
          page, token!);
    });
  }

  @override
  Future<Either<Failure, List<Service>>> getAllSubServiceInSystem(
      int serviceId, int page) async {
   final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
          (l) {
        return l;
      },
          (r) {
        token = r;
      },
    );
    return await _getServices(() {
      return remoteDataSource.getAllSubServiceInSystem(
          page, token!, serviceId);
    });
  }

  Future<Either<Failure, List<Service>>> _getServices(GetServices func) async {
    return performRequest<List<Service>>(func, networkInfo);
  }
}
