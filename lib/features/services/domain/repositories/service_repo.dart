import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/add_service.dart';
import '../entities/date.dart';
import '../entities/reservation.dart';
import '../entities/service_foundation.dart';

abstract class ServiceRepo {
  Future<Either<Failure, List<ServiceFoundation>>> getAllServiceForFoundation(
      int foundationId, int page);
  Future<Either<Failure, Unit>> reservationService(Reservation reservation);
  Future<Either<Failure, List<Date>>> getAvailableTime(int id);

  Future<Either<Failure, Unit>> addServiceToFoundation(AddService addService);
  Future<Either<Failure, Unit>> editService(AddService editService);
  Future<Either<Failure, Unit>> stopService(int id);
}
