import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/propose.dart';
import '../repositories/suggestions_repo.dart';

class ProposeNewServiceUsecase {
  final SuggestionsRepo repo;

  ProposeNewServiceUsecase(this.repo);

  Future<Either<Failure, Unit>> call(Propose propose) async {
    return await repo.proposeNewService(propose);
  }
}
