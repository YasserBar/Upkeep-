import 'package:dartz/dartz.dart';
import 'package:upkeep_plus/features/services/domain/entities/service_foundation.dart';
import '../entities/filter_foundations.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/foundations_repo.dart';

class FilterServicesFoundationsUsecase {
  final FoundationsRepo repo;

  FilterServicesFoundationsUsecase(this.repo);

  Future<Either<Failure, List<ServiceFoundation>>> call(
      FilterFoundations filterFoundation, int page) async {
    return await repo.filterFoundations(filterFoundation, page);
  }
}
