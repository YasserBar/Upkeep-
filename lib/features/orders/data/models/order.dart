import '../../domain/entities/order.dart';

class MyOrderModel extends MyOrder {
  const MyOrderModel({
    int? foundationServiceId,
    int? userId,
    String? name,
    required int id,
    required String date,
    required int assessment,
    required int accept,
    required int rejected,
    required int cancel,
    required String description,
    required String status,
    int? foundationId,
    int? serviceCost,
  }) : super(
          foundationServiceId: foundationServiceId,
          userId: userId,
          name: name,
          id: id,
          date: date,
          assessment: assessment,
          accept: accept,
          rejected: rejected,
          cancel: cancel,
          description: description,
          status: status,
          foundationId: foundationId,
          serviceCost: serviceCost,
        );

  factory MyOrderModel.fromJson(Map<String, dynamic> json) => MyOrderModel(
        foundationServiceId: json['foundation_service_id'] as int?,
        userId: json['user_id'] as int?,
        name: json['name'] as String?,
        id: json['id'] as int,
        date: json['date'] as String,
        assessment: json['assessment'] as int,
        accept: json['accept'] as int,
        rejected: json['rejected'] as int,
        cancel: json['cancel'] as int,
        description: json['description'] as String,
        status: json['status'] as String,
        foundationId: json['foundation_id'] as int?,
        serviceCost: json['service_cost'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'foundation_service_id': foundationServiceId,
        'user_id': userId,
        'name': name,
        'id': id,
        'date': date,
        'assessment': assessment,
        'accept': accept,
        'rejected': rejected,
        'cancel': cancel,
        'description': description,
        'status': status,
        'foundation_id': foundationId,
        'service_cost': serviceCost,
      };
}
