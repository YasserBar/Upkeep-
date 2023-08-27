import 'package:dartz/dartz.dart';
import 'package:upkeep_plus/features/foundations/domain/entities/foundation.dart';
import '../entities/filter_foundations.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/foundations_repo.dart';

class FilterFoundationsInSystemUsecase {
  final FoundationsRepo repo;

  FilterFoundationsInSystemUsecase(this.repo);

  Future<Either<Failure, List<Foundation>>> call(
      FilterFoundations filterFoundation, int page) async {
    return await repo.filterFoundationsInSystem(filterFoundation, page);
  }
}
