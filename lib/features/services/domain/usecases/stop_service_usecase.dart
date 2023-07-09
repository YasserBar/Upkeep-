import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/service_repo.dart';

class StopServiceUsecase {
  final ServiceRepo repo;

  StopServiceUsecase(this.repo);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repo.stopService(id);
  }
}
