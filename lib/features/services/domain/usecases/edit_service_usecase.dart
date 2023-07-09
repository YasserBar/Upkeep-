import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/add_service.dart';
import '../repositories/service_repo.dart';

class EditServiceUsecase {
  final ServiceRepo repo;

  EditServiceUsecase(this.repo);

  Future<Either<Failure, Unit>> call(AddService addService) async {
    return await repo.editService(addService);
  }
}
