import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/service.dart';
import '../repositories/categories_repo.dart';

class GetAllSubServiceInSystemUsecase {
  final CategoriesRepo repo;

  GetAllSubServiceInSystemUsecase(this.repo);

  Future<Either<Failure, List<Service>>> call(int serviceId, int page) async {
    return await repo.getAllSubServiceInSystem(serviceId, page);
  }
}
