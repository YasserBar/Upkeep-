import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/service.dart';
import '../repositories/categories_repo.dart';

class GetAllServiceInSystemUsecase {
  final CategoriesRepo repo;

  GetAllServiceInSystemUsecase(this.repo);

  Future<Either<Failure, List<Service>>> call(int page) async {
    return await repo.getAllServiceInSystem(page);
  }
}
