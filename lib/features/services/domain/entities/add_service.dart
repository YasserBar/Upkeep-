import 'package:equatable/equatable.dart';

class AddService extends Equatable {
  final int? id;
  final int? foundationId;
  final int? serviceId;
  final String description;
  final int serviceCost;
  final int numberOfResource;
  final int needActive;
  final String durationWork;
  final int dayAllowed;
  final String startSaturday;
  final String endSaturday;
  final String startSunday;
  final String endSunday;
  final String startMonday;
  final String endMonday;
  final String startTuesday;
  final String endTuesday;
  final String startWednesday;
  final String endWednesday;
  final String startThursday;
  final String endThursday;
  final String startFriday;
  final String endFriday;

  const AddService({
    this.id,
    this.foundationId,
    this.serviceId,
    required this.description,
    required this.serviceCost,
    required this.numberOfResource,
    required this.needActive,
    required this.dayAllowed,
    required this.durationWork,
    required this.startSaturday,
    required this.endSaturday,
    required this.startSunday,
    required this.endSunday,
    required this.startMonday,
    required this.endMonday,
    required this.startTuesday,
    required this.endTuesday,
    required this.startWednesday,
    required this.endWednesday,
    required this.startThursday,
    required this.endThursday,
    required this.startFriday,
    required this.endFriday,
  });
  @override
  List<Object?> get props {
    return [
      id,
      foundationId,
      serviceId,
      description,
      serviceCost,
      numberOfResource,
      needActive,
      dayAllowed,
      durationWork,
      startSaturday,
      endSaturday,
      startSunday,
      endSunday,
      startMonday,
      endMonday,
      startTuesday,
      endTuesday,
      startWednesday,
      endWednesday,
      startThursday,
      endThursday,
      startFriday,
      endFriday,
    ];
  }
}
