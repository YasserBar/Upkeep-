import 'package:dartz/dartz.dart';
import '../entities/my_suggestions.dart';
import '../entities/propose.dart';

import '../../../../core/errors/failures.dart';

abstract class SuggestionsRepo {
  Future<Either<Failure, List<MySuggestion>>> getAllMyPropose(
      int foundationId, int page);
  Future<Either<Failure, Unit>> proposeNewService(Propose propose);
}
