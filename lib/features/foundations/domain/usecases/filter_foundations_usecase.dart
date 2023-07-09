import 'package:dartz/dartz.dart';
import '../entities/filter_foundations.dart';

import '../../../../core/errors/failures.dart';
import '../entities/foundation.dart';
import '../repositories/foundations_repo.dart';

class FilterFoundationsUsecase {
  final FoundationsRepo repo;

  FilterFoundationsUsecase(this.repo);

  Future<Either<Failure, List<Foundation>>> call(
      FilterFoundations filterFoundation, int page) async {
    return await repo.filterFoundations(filterFoundation, page);
  }
}
