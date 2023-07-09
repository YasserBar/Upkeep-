import 'package:dartz/dartz.dart';
import '../../../../core/helpers/get_message.dart';
import '../datasources/locations_remote_data_source.dart';
import '../models/country.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/network_info.dart';
import '../../domain/entities/country.dart';
import '../../domain/repositories/locations_repo.dart';

typedef GetListLocations = Future<List<CountryModel>> Function();

class LocationsRepoImpl extends LocationsRepo {
  final LocationsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LocationsRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Country>>> getLocations() async {
    return await _getResponse(() {
      return remoteDataSource.getLocations();
    });
  }

  Future<Either<Failure, List<Country>>> _getResponse(
      GetListLocations func) async {
    return performRequest<List<Country>>(func, networkInfo);
  }
}
