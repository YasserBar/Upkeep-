import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/reservation.dart';
import '../repositories/service_repo.dart';

class ReservationServiceUsecase {
  final ServiceRepo repo;

  ReservationServiceUsecase(this.repo);

  Future<Either<Failure, Unit>> call(Reservation reservation) async {
    return await repo.reservationService(reservation);
  }
}
