import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/get_message.dart';
import '../../../../core/helpers/get_token.dart';
import '../../../../core/helpers/network_info.dart';
import '../../../../main.dart';
import '../../../auth/data/datasources/auth_local_data_source.dart';
import '../../domain/entities/add_service.dart';
import '../../domain/entities/date.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/entities/service_foundation.dart';
import '../../domain/repositories/service_repo.dart';
import '../datasources/service_remote_data_source.dart';
import '../models/add_service.dart';
import '../models/date.dart';
import '../models/reservation.dart';
import '../models/service_foundation.dart';

typedef GetServicesFoundation = Future<List<ServiceFoundationModel>> Function();
typedef GetAvailableTime = Future<List<DateModel>> Function();

class ServiceRepoImpl extends ServiceRepo {
  final ServiceRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ServiceRepoImpl(
      this.remoteDataSource, this.localDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<ServiceFoundation>>> getAllServiceForFoundation(
      int foundationId, int page) async {
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );

    return await _getServicesFoundation(() {
      return remoteDataSource.getAllServiceForFoundation(
          token!, foundationId, page);
    });
  }

  @override
  Future<Either<Failure, Unit>> reservationService(
      Reservation reservation) async {
    ReservationModel reservationModel = ReservationModel(
        id: reservation.id,
        date: reservation.date,
        description: reservation.description);
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );

    return await getMessage(() {
      return remoteDataSource.reservationService(token!, reservationModel);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, List<Date>>> getAvailableTime(int id) async {
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );

    return await _getAvailableTime(() {
      return remoteDataSource.getAvailableTime(token!, id);
    });
  }

  @override
  Future<Either<Failure, Unit>> addServiceToFoundation(
      AddService addService) async {
    AddServiceModel addServiceModel = AddServiceModel(
      foundationId: addService.foundationId,
      serviceId: addService.serviceId,
      description: addService.description,
      serviceCost: addService.serviceCost,
      numberOfResource: addService.numberOfResource,
      needActive: addService.needActive,
      dayAllowed: addService.dayAllowed,
      durationWork: addService.durationWork,
      startSaturday: addService.startSaturday,
      endSaturday: addService.endSaturday,
      startSunday: addService.startSunday,
      endSunday: addService.endSunday,
      startMonday: addService.startMonday,
      endMonday: addService.endMonday,
      startTuesday: addService.startTuesday,
      endTuesday: addService.endTuesday,
      startWednesday: addService.startWednesday,
      endWednesday: addService.endWednesday,
      startThursday: addService.startThursday,
      endThursday: addService.endThursday,
      startFriday: addService.startFriday,
      endFriday: addService.endFriday,
    );
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );

    return await getMessage(() {
      return remoteDataSource.addService(token!, addServiceModel);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, Unit>> editService(AddService editService) async {
    AddServiceModel editServiceModel = AddServiceModel(
      foundationId: editService.foundationId,
      serviceId: editService.serviceId,
      description: editService.description,
      serviceCost: editService.serviceCost,
      numberOfResource: editService.numberOfResource,
      needActive: editService.needActive,
      dayAllowed: editService.dayAllowed,
      durationWork: editService.durationWork,
      startSaturday: editService.startSaturday,
      endSaturday: editService.endSaturday,
      startSunday: editService.startSunday,
      endSunday: editService.endSunday,
      startMonday: editService.startMonday,
      endMonday: editService.endMonday,
      startTuesday: editService.startTuesday,
      endTuesday: editService.endTuesday,
      startWednesday: editService.startWednesday,
      endWednesday: editService.endWednesday,
      startThursday: editService.startThursday,
      endThursday: editService.endThursday,
      startFriday: editService.startFriday,
      endFriday: editService.endFriday,
    );
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );

    return await getMessage(() {
      return remoteDataSource.editService(token!, editServiceModel);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, Unit>> stopService(int id) async {
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );

    return await getMessage(() {
      return remoteDataSource.stopService(token!, id);
    }, networkInfo);
  }

  Future<Either<Failure, List<ServiceFoundation>>> _getServicesFoundation(
      GetServicesFoundation func) async {
    return performRequest<List<ServiceFoundation>>(func, networkInfo);
  }

  Future<Either<Failure, List<DateModel>>> _getAvailableTime(
      GetAvailableTime func) async {
    return performRequest<List<DateModel>>(func, networkInfo);
  }
}
