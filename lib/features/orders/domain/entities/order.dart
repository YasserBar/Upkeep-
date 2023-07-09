import 'package:equatable/equatable.dart';

class MyOrder extends Equatable {
  final int? foundationServiceId;
  final int? userId;
  final String? name;
  final int id;
  final String date;
  final int assessment;
  final int accept;
  final int rejected;
  final int cancel;
  final String description;
  final String status;
  final int? foundationId;
  final int? serviceCost;

  const MyOrder({
    this.foundationServiceId,
    this.userId,
    this.name,
    required this.id,
    required this.date,
    required this.assessment,
    required this.accept,
    required this.rejected,
    required this.cancel,
    required this.description,
    required this.status,
    this.foundationId,
    this.serviceCost,
  });

  @override
  List<Object?> get props {
    return [
      foundationServiceId,
      userId,
      name,
      id,
      date,
      assessment,
      accept,
      rejected,
      cancel,
      description,
      status,
      foundationId,
      serviceCost,
    ];
  }
}
