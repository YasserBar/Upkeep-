import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/add_service.dart';
import '../repositories/service_repo.dart';

class AddServiceToFoundationUsecase {
  final ServiceRepo repo;

  AddServiceToFoundationUsecase(this.repo);

  Future<Either<Failure, Unit>> call(AddService addService) async {
    return await repo.addServiceToFoundation(addService);
  }
}
