import 'package:equatable/equatable.dart';

class ServiceFoundation extends Equatable {
  final int id;
  final String photo;
  final String name;
  final String description;
  final int serviceCost;
  final String durationWork;

  const ServiceFoundation({
    required this.id,
    required this.photo,
    required this.name,
    required this.description,
    required this.serviceCost,
    required this.durationWork,
  });
  @override
  List<Object?> get props {
    return [
      id,
      photo,
      name,
      description,
      serviceCost,
      durationWork,
    ];
  }
}
