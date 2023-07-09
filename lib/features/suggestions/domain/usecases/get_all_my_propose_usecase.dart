import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/my_suggestions.dart';
import '../repositories/suggestions_repo.dart';

class GetAllMyProposeUsecase {
  final SuggestionsRepo repo;

  GetAllMyProposeUsecase(this.repo);

  Future<Either<Failure, List<MySuggestion>>> call(
      int foundationId, int page) async {
    return await repo.getAllMyPropose(foundationId, page);
  }
}
